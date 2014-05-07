class XingApiClient
  class Error < StandardError; end
  class UnknownHttpMethodError   < Error; end
  class FileMIMETypeUnknownError < Error; end

  class Request
    class Error < XingApiClient::Error
      attr_accessor :code, :api_name, :response

      def initialize(code = nil, api_name = nil, response = nil)
        @code     = code
        @api_name = api_name
        @response = response
      end

      def to_s
        [code, response.inspect].join(' - ')
      end
    end

    class UnknownResponseContentTypeError < Error; end
    class InvalidParametersError          < Error; end
    class InvalidOauthTokenError          < Error; end
    class ThrottlingError                 < Error; end
    class ResourceNotFoundError           < Error; end
    class AccessDeniedError               < Error; end
  end
end
