require 'spec_helper'

describe XingApiClient::Call::UsersMeIdCardCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersMeIdCardCall) } }

  describe '#get_users_me_id_card' do
    subject do
      call.
        should_receive(:make_request!).
        with(:get, "v1/users/me/id_card", {}, {:array_keys=>["id_card"]}).
        and_return({"id" => 1})

      call.get_users_me_id_card()
    end

    its(:class) { should == Hash }
    its(:keys) { should == ['id'] }
  end
end
