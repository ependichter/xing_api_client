require 'spec_helper'

describe XingApiClient do
  subject { XingApiClient }
  let(:instance){ subject.new('access_token_ABC123', 'secret_DEF456') }

  describe '.request_params' do
    let(:token) { double('request_token', authorize_url: 'www.url.sample') }
    before { subject.stub_chain(:consumer, :get_request_token).and_return(token) }

    it 'returns a hash with a request token and a auth url' do
      subject.request_params.should == { request_token: token, auth_url: 'www.url.sample'}
    end
  end

  describe '.authorize' do
    let(:request_token) { double('request_token') }
    let(:pin) { '1234' }
    let(:access_token) { double('access_token', token: 'access_token_ABC123', secret: 'secret_DEF456' ) }

    before do
      request_token.should_receive(:get_access_token).with(oauth_verifier: pin).and_return(access_token)
    end

    it 'returns a hash with a access token and a secret' do
      subject.authorize(request_token, pin).should == { access_token: 'access_token_ABC123', secret: 'secret_DEF456'}
    end
  end

  describe '.consumer' do
    it 'returns a OAuth::Consumer instance' do
      subject.send(:consumer).should be_kind_of(OAuth::Consumer)
    end
  end

  describe '.new' do
    it 'sets the intsance variable access_token to the first argument when it gets initialized' do
      instance.instance_variable_get('@access_token').should == 'access_token_ABC123'
    end

    it 'sets the intsance variable secret to the second argument when it gets initialized' do
      instance.instance_variable_get('@secret').should == 'secret_DEF456'
    end
  end

  describe '#consumer_token' do
    it 'returns a OAuth::ConsumerToken instance' do
      instance.send(:consumer_token).should be_kind_of(OAuth::ConsumerToken)
    end
  end
end
