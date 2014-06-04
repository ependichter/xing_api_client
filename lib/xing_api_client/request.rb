class XingApiClient
  class Request
    require_relative 'request/error'
    require 'parallel'
    require 'net/http/post/multipart'
    require 'pathname'
    require 'mimemagic'
    include Config
    include XingApiClient::Call

    ERROR_CLASSES = {
      'INVALID_PARAMETERS'  => InvalidParametersError,
      'INVALID_OAUTH_TOKEN' => InvalidOauthTokenError,
      'RATE_LIMIT_EXCEEDED' => ThrottlingError,
      'USER_NOT_FOUND'      => ResourceNotFoundError,
      403                   => AccessDeniedError,
      404                   => ResourceNotFoundError
    }

    def initialize(connection)
      @connection = connection
    end

  private
    attr_reader :connection

    def map_user(data)
      XingApiClient::Object::User.new data
    end

    def make_request!(verb, url, params = nil, options = {})
      options        = { array_keys: [], allowed_codes: [200] }.merge(options)
      url            = [config.host, url].join('/')
      request_params = add_default_values(params)

      result = handle_request(verb, url, request_params)
      data   = handle_result(result, options[:content_type])
      handle_error!(result.status, data, options[:allowed_codes])

      Array(options[:array_keys]).each { |key| data = data[key] }

      data
    end

    def generate_url_params(params)
      '?' + params.to_a.map{ |key, value| "#{key}=#{CGI.escape(value.to_s)}"}.join('&')
    end

    def add_default_values(params)
      return {} if params.nil? || params.empty?

      {}.tap do |result|
        params.each_pair do |key, value|
          value = case key
            when :offset
              value.to_i
            when :user_fields
              value || XingApiClient::Object::User::AVAILABLE_FIELDS.join(',')
            when :phone, :mobile_phone, :fax
              value.is_a?(Array) ? value.join("|") : value
            else
              value
            end

          result[key] = value
        end
      end
    end

    def handle_request(verb, url, params)
      verb, multipart = verb.to_s.split('_')

      if multipart
        handle_multipart_request(verb, url, params)
      else
        # Currently, the XING API contains a bug that results sometimes in an wrong signature error if some
        # data is sent via the body. Because of this, all parameters will be encoded and send via the url.
        connection.send(verb, url + generate_url_params(params))
      end
    end

    # Not automatic tested right now... Oo
    def handle_multipart_request(verb, url, params)
      multipart_key, file_path = params.delete(:multipart).to_a.flatten
      mimetype                 = MimeMagic.by_path file_path

      raise XingApiClient::Error::FileMIMETypeUnknownError if mimetype.nil?

      connection.send(verb, url, multipart_key => Faraday::UploadIO.new(file_path, mimetype))
    end

    def handle_result(result, content_type)
      if not result.body.to_s.empty?
        if content_type == 'text'
          result.body
        else
          begin
            JSON.parse(result.body)
          rescue JSON::ParserError
            raise XingApiClient::Error
          end
        end
      end
    end

    def handle_error!(code, data, allowed_codes)
      code = code.to_i
      return if Array(allowed_codes).include?(code)

      error_name  = data.nil? ? code : data['error_name']
      error_class = ERROR_CLASSES[error_name] || Error

      raise error_class.new(code, error_name, data)
    end
  end
end
