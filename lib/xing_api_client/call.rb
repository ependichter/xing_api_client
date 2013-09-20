Dir[File.dirname(__FILE__) + '/call/*.rb'].each { |name| require(name) }

class XingApiClient
  module Call
    def self.included(base)
      XingApiClient::Call::Registry.register_call_methods base
    end
  end
end



