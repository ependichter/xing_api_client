class XingApiClient
  module Config
    DEFAULT_SETTINGS = {
      host: 'https://api.xing.com',
      request_token_path: '/v1/request_token',
      authorize_path: '/v1/authorize',
      access_token_path: '/v1/access_token',
      consumer_key: nil,
      consumer_secret: nil,
      callback_url: nil
    }

    @settings = ::OpenStruct.new(DEFAULT_SETTINGS)

    def self.set(hash)
      @settings = ::OpenStruct.new(DEFAULT_SETTINGS.merge(hash))
    end

    def self.load_file(path)
      set YAML.load_file(path)
    end

    def self.load_env(prefix = nil)
      prefix ||= self.to_s.split('::').first.upcase

      hash = {}
      DEFAULT_SETTINGS.keys.each do |key|
        hash[key] = ENV["#{prefix}_#{key.upcase}"] || DEFAULT_SETTINGS[key]
      end
      set hash
    end

  private
    def config
      XingApiClient::Config.instance_variable_get('@settings')
    end
  end
end
