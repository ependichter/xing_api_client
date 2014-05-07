require 'spec_helper'

describe XingApiClient::Call::UsersLegalInformationCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersLegalInformationCall) } }

  describe '#get_users_legal_information' do
    context "with no options" do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/legal_information", {}, {:array_keys=>["legal_information"]}).
          and_return({"content" => nil})

        call.get_users_legal_information()
      end

      its(:class) { should == Hash }
      its(:keys) { should == ['content'] }
    end

    context "with all options" do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/1_abcdef/legal_information", {}, {:array_keys=>["legal_information"]}).
          and_return({"content" => nil})

        call.get_users_legal_information('1_abcdef')
      end

      its(:class) { should == Hash }
      its(:keys) { should == ['content'] }
    end
  end
end
