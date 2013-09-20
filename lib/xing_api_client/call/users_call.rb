class XingApiClient
  module Call
    module UsersCall
      def get_users(options = {})
        id = options[:id] || 'me'

        make_request!(:get, "v1/users/#{id}", {}, array_keys: "users").first
      end
    end
  end
end
