class XingApiClient
  module Call
    module UsersContactsCall
      include Base

      def get_users_contacts(options = {})
        id     = options[:id] || 'me'
        offset = options[:offset]
        limit  = options[:limit]
        fields = options[:fields]

        params = { user_fields: fields }
        params.merge!(order_by: options[:order]) if options[:order] == 'last_name'

        result = make_request!(:get, "v1/users/#{id}/contacts", params.merge(limit: (limit || 100), offset: offset), array_keys: "contacts")

        request_loop(result["total"].to_i, result["users"], offset, limit, 100) do |result, steps|
          Parallel.map(steps, in_threads: 2) do |offset|
            make_request!(:get, "v1/users/#{id}/contacts", params.merge(limit: 100, offset: offset), array_keys: ["contacts", "users"])
          end.each { |r| result.concat r }
        end
      end
    end
  end
end
