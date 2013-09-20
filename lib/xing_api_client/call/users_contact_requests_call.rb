class XingApiClient
  module Call
    module UsersContactRequestsCall
      include Base

      def get_users_contact_requests(options = {})
        id              = options[:id]     || 'me'
        offset          = options[:offset] || 0
        limit           = options[:limit]
        fields          = options[:fields]

        make_request!(:get, "v1/users/#{id}/contact_requests", { limit: (limit || 100), offset: offset, user_fields: fields }, array_keys: ["contact_requests"])
      end


      def delete_users_contact_requests(recipient_id, options = {})
        id = options[:id] || 'me'

        make_request!(:delete, "v1/users/#{id}/contact_requests/#{recipient_id}", {}, allowed_codes: 204)
      end

      def post_users_contact_requests(recipient_id, message)
        make_request!(:post, "v1/users/#{recipient_id}/contact_requests", { message: message }, content_type: 'text', allowed_codes: 201)
      end

      def put_users_contact_requests_accept(recipient_id, options = {})
        id = options[:id] || 'me'

        make_request!(:put, "v1/users/#{id}/contact_requests/#{recipient_id}/accept", {}, allowed_codes: 204)
      end

      def get_users_contact_requests_sent(options = {})
        id              = options[:id]     || 'me'
        offset          = options[:offset] || 0
        limit           = options[:limit]

        make_request!(:get, "v1/users/#{id}/contact_requests/sent", {}, array_keys: "contact_requests")
      end
    end
  end
end
