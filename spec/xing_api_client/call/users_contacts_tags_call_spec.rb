require 'spec_helper'

describe XingApiClient::Call::UsersContactsTagsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersContactsTagsCall) } }

  describe '#get_users_contacts_tags' do
    subject do
      call.
        should_receive(:make_request!).
        with(:get, "v1/users/me/contacts/:contact_id/tags", {}, {:array_keys=>"tags"}).
        and_return("total" => 242, "items" => [{"tag" => 1},{"tag" => 2}])

      call.get_users_contacts_tags(':contact_id')
    end

    its(:class) { should == Array }
    its(:size)  { should == 2 }
    its(:total) { should == 242 }
  end
end
