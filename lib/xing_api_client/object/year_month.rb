class XingApiClient
  class Object
    class YearMonth
      require 'time'

      attr_accessor :year, :month

      def initialize(value)
        @value = value
        self.year, self.month = @value.to_s.split('-').map{ |s| s.to_i if s}
      end

      def <=>(an_other)
        to_date <=> an_other.to_date
      end

      def to_date
        if year.nil?
          Date.new
        elsif month.nil?
          Date.parse("#{year}-1-1")
        else
          Date.parse("#{year}-#{month}-1")
        end
      end
    end
  end
end
