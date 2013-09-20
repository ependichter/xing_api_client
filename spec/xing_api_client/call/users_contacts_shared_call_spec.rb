require 'spec_helper'

describe XingApiClient::Call::UsersContactsSharedCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersContactsSharedCall) } }

  describe '#get_users_contacts_shared' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:other_user_id/contacts/shared", {:user_fields=>nil, :limit=>100, :offset=>nil}, {:array_keys=>"shared_contacts"}).
          and_return("users" => [{'id' => 1}], "total" => '242')
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:other_user_id/contacts/shared", {:user_fields=>nil, :limit=>100, :offset=>100}, {:array_keys=>["shared_contacts", "users"]}).
          and_return([{'id' => 2}])
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:other_user_id/contacts/shared", {:user_fields=>nil, :limit=>100, :offset=>200}, {:array_keys=>["shared_contacts", "users"]}).
          and_return([{'id' => 3}])

        call.get_users_contacts_shared(':other_user_id')
      end

      its(:class) { should == Array }
      its(:size)  { should == 3 }
      its(:total) { should == 242 }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:other_user_id/contacts/shared", {:user_fields=>[:id, :page_name], :limit=>20, :offset=>5}, {:array_keys=>"shared_contacts"}).
          and_return("users" => [{'id' => 1}], "total" => '242')

        call.get_users_contacts_shared(':other_user_id', id: ':user_id', offset: 5 ,limit: 20, fields: [:id, :page_name])
      end

      its(:class) { should == Array }
      its(:size)  { should == 1 }
      its(:total) { should == 242 }
    end
  end
end
