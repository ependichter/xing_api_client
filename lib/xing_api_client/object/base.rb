class XingApiClient
  class Object
    module Base
      def initialize(data)
        @data = data.with_indifferent_access
      end

      def method_missing(method_name, *args, &block)
        if @data.has_key? method_name
          eigenclass = class << self; self; end
          eigenclass.class_eval do
            define_method(method_name) do
              @data[method_name]
            end
          end
          send(method_name, *args, &block)
        else
          super
        end
      end
    end
  end
end
