class XingApiClient
  module Call
    module UsersContactsTagsCall
      def get_users_contacts_tags(contact_id)
        request = make_request!(:get, "v1/users/me/contacts/#{contact_id}/tags", {}, array_keys: "tags")

        request["items"].tap do |tags|
          tags.map!{ |t| t["tag"] }.sort!
          tags.define_singleton_method :total, -> { request["total"].to_i }
        end
      end
    end
  end
end
