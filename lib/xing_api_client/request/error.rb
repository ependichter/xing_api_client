class XingApiClient
  class Request
    class Error < StandardError
      attr_accessor :code, :api_name, :response

      def initialize(code, api_name, response)
        @code     = code
        @api_name = api_name
        @response = response
      end

      def to_s
        [code, response.inspect].join(' - ')
      end
    end

    class InvalidParametersError < Error; end
    class InvalidOauthTokenError < Error; end
    class ThrottlingError        < Error; end
    class ResourceNotFoundError  < Error; end
    class AccessDeniedError      < Error; end
  end
end
