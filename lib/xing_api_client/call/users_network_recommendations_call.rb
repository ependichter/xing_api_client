class XingApiClient
  module Call
    module UsersNetworkRecommendationsCall
      def get_users_network_recommendations(options = {})
        offset = options[:offset]
        limit  = options[:limit]
        params = { user_id: "me", user_fields: options[:fields] }
        params.merge!(since: options[:similar_user_id]) unless options[:similar_user_id].nil?

        request = make_request!(:get, "v1/users/me/network/recommendations", params.merge(limit: (limit || 100), offset: offset), array_keys: "user_recommendations")

        request["recommendations"].tap do |collection|
          collection.define_singleton_method :total, -> { request["total"].to_i }
        end
      end

      def delete_users_network_recommendations(id)
        make_request!(:delete, "v1/users/me/network/recommendations/#{id}", {}, allowed_codes: 204)
      end
    end
  end
end
