require 'spec_helper'

describe XingApiClient::Call::UsersCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersCall) } }

  describe '#get_users' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me", {}, {:array_keys=>"users"}).
          and_return([{'id' => ':user_id'}])

        call.get_users()
      end

      its(:class) { should == Hash }
      its(:keys)  { should == ['id'] }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id", {}, {:array_keys=>"users"}).
          and_return([{'id' => ':user_id'}])


        call.get_users(id: ':user_id')
      end

      its(:class) { should == Hash }
      its(:keys)  { should == ['id'] }
    end
  end
end





