class XingApiClient
  class Request
    require 'xing_api_client/request/error'
    require 'parallel'
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

      result = if verb != :post
        consumer_token.request(verb, url + generate_url_params(request_params))
      else
        consumer_token.request(verb, url, request_params)
      end

      code = result.code.to_i

      data = unless result.body.nil?
        if options[:content_type] == 'text'
          result.body
        else
          JSON.parse(result.body)
        end
      end

      handle_error!(code, data) if not Array(options[:allowed_codes]).include?(code)

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

    def handle_error!(code, data)
      error_class = ERROR_CLASSES[data.nil? ? code : data['error_name']] || Error

      raise error_class.new(code, data['error_name'], data)
    end
  end
end
