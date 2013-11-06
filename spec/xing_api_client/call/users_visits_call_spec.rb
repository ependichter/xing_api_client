require 'spec_helper'

describe XingApiClient::Call::UsersVisitsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersVisitsCall) } }

  describe '#get_users_visits' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/visits", {:strip_html=>false, :limit=>100, :offset=>nil}, {:array_keys=>"visits"}).
          and_return([])

        call.get_users_visits()
      end

      its(:class) { should == Array }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/visits", {:strip_html=>true, :since=>"12345", :limit=>"99", :offset=>"30"}, {:array_keys=>"visits"}).
          and_return([])

        call.get_users_visits(id: ':user_id', offset: '30', limit: '99', strip_html: true, since: '12345')
      end

      its(:class) { should == Array }
    end
  end

  describe '#post_users_visits' do
    subject do
      call.
        should_receive(:make_request!).
        with(:post, "v1/users/some-message/visits", {}, {:allowed_codes=>201, :content_type=>"text"}).
        and_return(nil)

      call.post_users_visits('some-message')
    end

    its(:class) { should == NilClass }
  end
end
