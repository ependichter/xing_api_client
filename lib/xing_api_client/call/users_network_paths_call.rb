class XingApiClient
  module Call
    module UsersNetworkPathsCall
      def get_users_network_paths(other_user_id, options = {})
        id     = options[:id]     || 'me'
        offset = options[:offset] || 0
        limit  = options[:limit]
        fields = options[:fields]

        result = make_request!(:get, "v1/users/#{id}/network/#{other_user_id}/paths", {}, array_keys: ["contact_paths"])
        result['paths'].tap do |collection|
          collection.define_singleton_method :distance, -> { result["distance"].to_i }
          collection.define_singleton_method :total, -> { result["total"].to_i }
        end
      end
    end
  end
end
