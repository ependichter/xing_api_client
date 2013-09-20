class XingApiClient
  module Call
    module UsersFindByEmailsCall
      include Base

      def get_users_find_by_emails(emails, options = {})
        params = {
          emails: emails,
          user_fields: options[:fields]
        }
        params.merge!(hash_function: options[:hash_function]) if options[:hash_function] == 'MD5'

        result = make_request!(:get, "v1/users/find_by_emails", params, array_keys: ["results"])

        result["items"].tap do |collection|
          collection.define_singleton_method :total, -> { result["total"] }
        end
      end
    end
  end
end
