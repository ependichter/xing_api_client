class XingApiClient
  module Call
    module UsersMeIdCardCall
      def get_users_me_id_card
        make_request!(:get, "v1/users/me/id_card", {}, array_keys: ["id_card"])
      end
    end
  end
end
