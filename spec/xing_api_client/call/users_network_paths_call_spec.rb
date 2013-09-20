require 'spec_helper'

describe XingApiClient::Call::UsersNetworkPathsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersNetworkPathsCall) } }

  describe '#get_users_network_paths' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/network/:other_user_id/paths", {}, {:array_keys=>["contact_paths"]}).
          and_return({"paths" => [], "distance" => 2, "total" => '242'})

        call.get_users_network_paths(':other_user_id')
      end

      its(:class) { should == Array }
      its(:distance)  { should == 2 }
      its(:total)  { should == 242 }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/network/:other_user_id/paths", {}, {:array_keys=>["contact_paths"]}).
          and_return({"paths" => [], "distance" => 2, "total" => '242'})

        call.get_users_network_paths(':other_user_id', id: ':user_id')
      end

      its(:class) { should == Array }
      its(:distance)  { should == 2 }
      its(:total)  { should == 242 }
    end
  end
end
