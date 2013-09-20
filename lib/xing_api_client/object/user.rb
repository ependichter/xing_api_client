class XingApiClient
  class Object
    class User
      include Base
      AVAILABLE_FIELDS = ["id", "first_name", "last_name", "display_name", "page_name", "employment_status", "gender", "birth_date", "active_email", "time_zone", "premium_services", "badges", "wants", "haves", "interests", "organisation_member", "languages", "private_address", "business_address", "web_profiles", "instant_messaging_accounts", "professional_experience", "educational_background", "photo_urls", "permalink"]

      def private_address
        @private_address ||= XingApiClient::Object::Address.new(@data['private_address'])
      end

      def business_address
        @business_address ||= XingApiClient::Object::Address.new(@data['business_address'])
      end

      def professional_experience
        @professional_experience ||= begin
          [XingApiClient::Object::Company.new(@data['professional_experience']['primary_company'])] +
            @data['professional_experience']['non_primary_companies'].map{ |c| XingApiClient::Object::Company.new(c)}
        end
      end

      def birth_date
        h = @data['birth_date']

        Date.parse [h['year'],h['month'],h['day']].join('-') rescue nil
      end
    end
  end
end
