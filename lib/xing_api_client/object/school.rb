class XingApiClient
  class Object
    class School
      include Base

      def begin_date
        @begin_date ||= XingApiClient::Object::YearMonth.new(@data['begin_date'])
      end

      def end_date
        @end_date ||= XingApiClient::Object::YearMonth.new(@data['end_date'])
      end
    end
  end
end
