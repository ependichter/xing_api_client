require 'spec_helper'

describe XingApiClient::Call::UsersBookmarksCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersBookmarksCall) } }

  describe '#get_users_bookmarks' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/bookmarks", {limit: 100, offset: 0, user_fields: nil}, {array_keys: "bookmarks"}).
          and_return("total" => 202, "items" => [{"id" => 1}])
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/bookmarks", {:limit=>100, :offset=>100, :user_fields=>nil}, {:array_keys=>["bookmarks", "items"]}).
          and_return([{"id" => 2}])
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/bookmarks", {:limit=>100, :offset=>200, :user_fields=>nil}, {:array_keys=>["bookmarks", "items"]}).
          and_return([{"id" => 3}])

        call.get_users_bookmarks()
      end

      its(:size)  { should == 3 }
      its(:class) { should == Array }
      its(:total) { should == 202 }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/bookmarks", {:limit=>13, :offset=>5, :user_fields=>[:id, :page_name]}, {:array_keys=>"bookmarks"}).
          and_return("total" => 202, "items" => [{"id" => 1}])


        call.get_users_bookmarks(id: ':user_id', offset: 5, limit: 13, fields: [:id, :page_name])
      end

      its(:size)  { should == 1 }
      its(:class) { should == Array }
      its(:total) { should == 202 }
    end
  end

  describe '#put_users_bookmarks' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:put, "v1/users/me/bookmarks/:bookmark_id", {}, {:allowed_codes=>204})

        call.put_users_bookmarks(':bookmark_id')
      end

      its(:class)  { should == NilClass }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:put, "v1/users/:user_id/bookmarks/:bookmark_id", {}, {:allowed_codes=>204})

        call.put_users_bookmarks(':bookmark_id', id: ':user_id')
      end

      its(:class)  { should == NilClass }
    end
  end

  describe '#delete_users_bookmarks' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:delete, "v1/users/me/bookmarks/:bookmark_id", {}, {:allowed_codes=>204})

        call.delete_users_bookmarks(':bookmark_id')
      end

      its(:class)  { should == NilClass }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:delete, "v1/users/:user_id/bookmarks/:bookmark_id", {}, {:allowed_codes=>204})

        call.delete_users_bookmarks(':bookmark_id', id: ':user_id')
      end

      its(:class)  { should == NilClass }
    end
  end
end





