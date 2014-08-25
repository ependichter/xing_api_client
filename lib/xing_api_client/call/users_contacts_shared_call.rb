require_relative 'base'

class XingApiClient
  module Call
    module UsersContactsSharedCall
      include Base

      def get_users_contacts_shared(other_user_id, options = {})
        offset   = options[:offset]
        limit    = options[:limit]
        fields   = options[:fields]

        params = { user_fields: fields }
        params.merge!(order_by: options[:order]) if options[:order] == 'last_name'

        result = make_request!(:get, "v1/users/#{other_user_id}/contacts/shared", params.merge(limit: (limit || 100), offset: offset), array_keys: "shared_contacts")

        request_loop(result["total"].to_i, result["users"], offset, limit, 100) do |result, steps|
          Parallel.map(steps, in_threads: 2) do |offset|
            make_request!(:get, "v1/users/#{other_user_id}/contacts/shared", params.merge(limit: 100, offset: offset), array_keys: ["shared_contacts", "users"])
          end.each { |r| result.concat r }
        end
      end
    end
  end
end
