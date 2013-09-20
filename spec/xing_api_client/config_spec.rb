require 'spec_helper'

describe XingApiClient::Config do
  subject{ XingApiClient.new(nil, nil).send(:config) }

  describe 'XingApiClient class and instance has a config method' do
    context 'When it gets extended, it...' do
      it 'offers a .config method that offers the config values via methods' do
        XingApiClient.send(:config).request_token_path.should == '/v1/request_token'
      end
    end


    context 'When it gets included, it...' do
      it 'offers a #config method that offers the config values via methods' do
        subject.request_token_path.should == '/v1/request_token'
      end
    end
  end

  shared_examples "only defaults are set" do
    its(:host)               { should == 'https://api.xing.com' }
    its(:request_token_path) { should == '/v1/request_token' }
    its(:authorize_path)     { should == '/v1/authorize' }
    its(:access_token_path)  { should == '/v1/access_token' }
    its(:consumer_secret)    { should == nil }
    its(:callback_url)       { should == nil }
  end

  describe 'Default vaulues are available' do
    its(:consumer_key) { should == nil }
    it_behaves_like "only defaults are set"
  end

  describe '.set' do
    before { XingApiClient::Config.set(consumer_key: 'test_set') }
    its(:consumer_key) { should == 'test_set' }
    it_behaves_like "only defaults are set"
  end

  describe '.load_file' do
    before do
      YAML.should_receive(:load_file).with('path/file.yml').and_return(consumer_key: 'test_load_file')
      XingApiClient::Config.load_file('path/file.yml')
    end

    its(:consumer_key) { should == 'test_load_file' }
    it_behaves_like "only defaults are set"
  end

  describe '.load_env' do
    before do
      ENV.should_receive(:[]).with('XINGAPICLIENT_HOST').and_return(nil)
      ENV.should_receive(:[]).with('XINGAPICLIENT_REQUEST_TOKEN_PATH').and_return(nil)
      ENV.should_receive(:[]).with('XINGAPICLIENT_AUTHORIZE_PATH').and_return(nil)
      ENV.should_receive(:[]).with('XINGAPICLIENT_ACCESS_TOKEN_PATH').and_return(nil)
      ENV.should_receive(:[]).with('XINGAPICLIENT_CONSUMER_KEY').and_return('test_load_env')
      ENV.should_receive(:[]).with('XINGAPICLIENT_CONSUMER_SECRET').and_return(nil)
      ENV.should_receive(:[]).with('XINGAPICLIENT_CALLBACK_URL').and_return(nil)

      XingApiClient::Config.load_env()
    end

    its(:consumer_key) { should == 'test_load_env' }
    it_behaves_like "only defaults are set"
  end
end
