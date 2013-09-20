require 'spec_helper'

describe XingApiClient::Request::Error do

  describe '.new' do
    subject do
      XingApiClient::Request::Error.
        new(200, 'RSPEC_EXCEPTION', {error_name: 'RSPEC_EXCEPTION'})
    end

    its(:code)     { should == 200 }
    its(:api_name) { should == 'RSPEC_EXCEPTION' }
    its(:response) { should == {error_name: 'RSPEC_EXCEPTION'} }
  end
end
