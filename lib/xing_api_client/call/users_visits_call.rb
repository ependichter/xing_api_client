class XingApiClient
  module Call
    module UsersVisitsCall
      def get_users_visits(options = {})
        id = options[:id] || 'me'

        offset     = options[:offset]
        limit      = options[:limit]
        strip_html = options[:strip_html] || false

        params = { strip_html: strip_html }
        params.merge!(since: options[:since]) unless options[:since].nil?

        make_request!(:get, "v1/users/#{id}/visits", params.merge(limit: (limit || 100), offset: offset), array_keys: "visits")
      end

      def post_users_visits(user_id)
        make_request!(:post, "v1/users/#{user_id}/visits", {}, allowed_codes: 201, content_type: 'text' )
      end
    end
  end
end
