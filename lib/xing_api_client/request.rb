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

    def initialize(consumer_token)
      @consumer_token = consumer_token
    end

  private
    attr_reader :consumer_token

    def map_user(data)
      XingApiClient::Object::User.new data
    end

    def make_request!(verb, url, params = nil, options = {})
      options        = { array_keys: [], allowed_codes: [200] }.merge(options)
      url            = [config.host, url].join('/')

      request_params = add_default_values(params)

      result = handle_request(verb, url, request_params)
      data   = handle_result(result, options[:content_type])
      handle_error!(result.code, data, options[:allowed_codes])

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
      elsif verb == "get"
        consumer_token.request(verb, url + generate_url_params(params))
      else
        consumer_token.request(verb, url, params)
      end
    end

    # Not automatic tested right now... Oo
    def handle_multipart_request(verb, url, params)
      uri = URI.parse(url)
      multipart_class = case verb.to_sym
      when :post
        Net::HTTP::Post::Multipart
      when :put
        Net::HTTP::Put::Multipart
      else
        raise XingApiClient::Error::UnknownHttpMethodError
      end
      multipart_key, file_path = params.delete(:multipart).to_a.flatten
      mimetype                 = MimeMagic.by_path file_path

      raise XingApiClient::Error::FileMIMETypeUnknownError if mimetype.nil?

      file_name = Pathname.new file_path

      request_response = nil
      File.open(file_path) do |image|
        request = multipart_class.new(uri.path, multipart_key => UploadIO.new(image, mimetype, file_name))
        consumer_token.sign! request
        request_response = Net::HTTP.start(uri.host, uri.port, use_ssl: (uri.scheme == 'https')) do |http|
          http.request(request)
        end
      end
      request_response
    end

    def handle_result(result, content_type)
      unless result.body.nil?
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

      error_class = ERROR_CLASSES[data.nil? ? code : data['error_name']] || Error

      raise error_class.new(code, data['error_name'], data)
    end
  end
end
