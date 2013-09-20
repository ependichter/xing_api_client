require 'spec_helper'

describe XingApiClient::Call::UsersContactsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersContactsCall) } }

  describe '#get_users_contacts' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/contacts", {:limit=>100, :offset=>nil, :user_fields=>nil}, {:array_keys=>"contacts"}).
          and_return("users" => [{'id' => 1}], "total" => '242')
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/contacts", {:limit=>100, :offset=>100, :user_fields=>nil}, {:array_keys=>["contacts", "users"]}).
          and_return([{'id' => 2}])
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/contacts", {:limit=>100, :offset=>200, :user_fields=>nil}, {:array_keys=>["contacts", "users"]}).
          and_return([{'id' => 3}])

        call.get_users_contacts()
      end

      its(:class) { should == Array }
      its(:size)  { should == 3 }
      its(:total) { should == 242 }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/:user_id/contacts", {:limit=>20, :offset=>5, :user_fields=>[:id, :page_name]}, {:array_keys=>"contacts"}).
          and_return("users" => [{'id' => 1}], "total" => '242')

        call.get_users_contacts(id: ':user_id', offset: 5 ,limit: 20, fields: [:id, :page_name])
      end

      its(:class) { should == Array }
      its(:size)  { should == 1 }
      its(:total) { should == 242 }
    end
  end
end
