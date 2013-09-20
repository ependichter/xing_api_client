require 'spec_helper'

describe XingApiClient::Call::UsersProfileMessageCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersProfileMessageCall) } }

  describe '#get_users_profile_message' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/profile_message", {}, {:array_keys=>["profile_message"]}).
          and_return("message" => nil)

        call.get_users_profile_message()
      end

      its(:class) { should == Hash }
      its(:keys)  { should == ['message'] }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/profile_message", {}, {:array_keys=>["profile_message"]}).
          and_return("message" => nil)

        call.get_users_profile_message(id: ':user_id')
      end

      its(:class) { should == Hash }
      its(:keys)  { should == ['message'] }
    end
  end

  describe '#put_users_profile_message' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:put, "v1/users/me/profile_message", {:message=>"some-message"}, {:allowed_codes=>204}).
          and_return(nil)

        call.put_users_profile_message('some-message')
      end

      its(:class) { should == NilClass }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:put, "v1/users/:user_id/profile_message", {:message=>"some-message"}, {:allowed_codes=>204}).
          and_return(nil)

        call.put_users_profile_message('some-message', id: ':user_id')
      end

      its(:class) { should == NilClass }
    end
  end
end
