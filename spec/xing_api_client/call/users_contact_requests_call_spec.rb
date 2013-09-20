require 'spec_helper'

describe XingApiClient::Call::UsersContactRequestsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersContactRequestsCall) } }

  describe '#get_users_contact_requests' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/contact_requests", {:limit=>100, :offset=>0, :user_fields=>nil}, {:array_keys=>["contact_requests"]}).
          and_return([{"id" => 1}])

        call.get_users_contact_requests()
      end

      its(:size)  { should == 1 }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/contact_requests", {:limit=>30, :offset=>5, :user_fields=>["id", "display_name"]}, {:array_keys=>["contact_requests"]}).
          and_return([{"id" => 1}])

        call.get_users_contact_requests(id: ':user_id', offset: 5, limit: 30, fields: ['id', 'display_name'])
      end

      its(:size)  { should == 1 }
    end
  end

  describe '#delete_users_contact_requests' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:delete, "v1/users/me/contact_requests/:recipient_id", {}, {:allowed_codes=>204}).
          and_return(nil)

        call.delete_users_contact_requests(':recipient_id')
      end

      its(:class)  { should == NilClass }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:delete, "v1/users/:user_id/contact_requests/:recipient_id", {}, {:allowed_codes=>204}).
          and_return(nil)

        call.delete_users_contact_requests(':recipient_id', id: ':user_id')
      end

      its(:class)  { should == NilClass }
    end
  end

  describe '#post_users_contact_requests' do
    subject do
      call.
        should_receive(:make_request!).
        with(:post, "v1/users/:recipient_id/contact_requests", {:message=>"message"}, {:content_type=>"text", :allowed_codes=>201}).
        and_return(nil)

      call.post_users_contact_requests(':recipient_id', 'message')
    end

    its(:class)  { should == NilClass }
  end

  describe '#put_users_contact_requests_accept' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:put, "v1/users/me/contact_requests/:recipient_id/accept", {}, {:allowed_codes=>204}).
          and_return(nil)

        call.put_users_contact_requests_accept(':recipient_id')
      end

      its(:class)  { should == NilClass }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:put, "v1/users/:user_id/contact_requests/:recipient_id/accept", {}, {:allowed_codes=>204}).
          and_return(nil)

        call.put_users_contact_requests_accept(':recipient_id', id: ':user_id')
      end

      its(:class)  { should == NilClass }
    end
  end

  describe '#get_users_contact_requests_sent' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/contact_requests/sent", {}, {:array_keys=>"contact_requests"}).
          and_return(nil)

        call.get_users_contact_requests_sent()
      end

      its(:class)  { should == NilClass }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/contact_requests/sent", {}, {:array_keys=>"contact_requests"}).
          and_return(nil)

        call.get_users_contact_requests_sent(id: ':user_id', offset: 5, limit: 30)
      end

      its(:class)  { should == NilClass }
    end
  end
end
