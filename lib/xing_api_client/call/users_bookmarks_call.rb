class XingApiClient
  module Call
    module UsersBookmarksCall
      include Base

      def get_users_bookmarks(options = {})

        id       = options[:id]       || 'me'
        offset   = options[:offset]   || 0
        fields   = options[:fields]
        limit    = options[:limit]

        result = make_request!(:get, "v1/users/#{id}/bookmarks", { limit: (limit || 100), offset: offset, user_fields: fields }, array_keys: "bookmarks")

        request_loop(result["total"].to_i, result["items"], offset, limit, 100) do |result, steps|
          Parallel.map(steps, in_threads: 2) do |offset|
            make_request!(:get, "v1/users/#{id}/bookmarks", { limit: 100, offset: offset, user_fields: fields }, array_keys: ["bookmarks", "items"])
          end.each { |r| result.concat r }

        end
      end

      def put_users_bookmarks(bookmark_id, options = {})
        id = options[:id] || 'me'

        make_request!(:put, "v1/users/#{id}/bookmarks/#{bookmark_id}", {}, allowed_codes: 204)
      end

      def delete_users_bookmarks(bookmark_id, options = {})
        id = options[:id] || 'me'

        make_request!(:delete, "v1/users/#{id}/bookmarks/#{bookmark_id}", {}, allowed_codes: 204)
      end
    end
  end
end
