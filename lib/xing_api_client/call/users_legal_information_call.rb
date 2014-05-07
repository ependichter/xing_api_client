class XingApiClient
  module Call
    module UsersLegalInformationCall
      def get_users_legal_information(user_id = 'me')
        make_request!(:get, "v1/users/#{user_id}/legal_information", {}, array_keys: ["legal_information"])
      end
    end
  end
end
