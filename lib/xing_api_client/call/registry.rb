class XingApiClient
  module Call
    module Registry
      def self.register_call_methods(target_class)
        call_methods = {}

        names = Dir.entries(File.dirname(__FILE__)).select{ |file| file.match(/_call.rb$/)}
        names.map!{ |name| name.gsub(/.rb$/, '') }

        names.each do |name|
          constant = eval('XingApiClient::Call::' + name.split('_').map{ |s| "#{s[0].upcase}#{s[1..-1]}"}.join)
          target_class.send :include, constant
          call_methods[constant.instance_methods.first] = constant
        end

        target_class.send(:define_method, :call_methods) do
          call_methods
        end
      end
    end
  end
end
