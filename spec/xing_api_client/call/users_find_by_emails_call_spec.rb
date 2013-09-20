require 'spec_helper'

describe XingApiClient::Call::UsersFindByEmailsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersFindByEmailsCall) } }

  describe '#get_users_find_by_emails' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/find_by_emails", {:emails=>"email@host.de", :user_fields=>nil}, {:array_keys=>["results"]}).
          and_return("total" => 202, "items" => [{"id" => 1},{"id" => 2}])

        call.get_users_find_by_emails('email@host.de')
      end

      its(:class) { should == Array }
      its(:size)  { should == 2 }
      its(:total) { should == 202 }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/find_by_emails", {:emails=>"email@host.de", :user_fields=>[:id, :page_name]}, {:array_keys=>["results"]}).
          and_return("total" => 202, "items" => [{"id" => 1},{"id" => 2}])

        call.get_users_find_by_emails('email@host.de', fields: [:id, :page_name])
      end

      its(:class) { should == Array }
      its(:size)  { should == 2 }
      its(:total) { should == 202 }
    end
  end
end
