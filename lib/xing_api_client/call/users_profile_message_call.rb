class XingApiClient
  module Call
    module UsersProfileMessageCall
      include Base

      def get_users_profile_message(options = {})
        id = options[:id] || 'me'

        make_request!(:get, "v1/users/#{id}/profile_message", {}, array_keys: ["profile_message"])
      end

      def put_users_profile_message(message, options = {})
        id = options[:id] || 'me'

        params = { message: message }
        params.merge!( :public => options[:public] ) if options[:public]

        make_request!(:put, "v1/users/#{id}/profile_message", params, allowed_codes: 204 )
      end
    end
  end
end
