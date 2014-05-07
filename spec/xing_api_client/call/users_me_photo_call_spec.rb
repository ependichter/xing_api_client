require 'spec_helper'

describe XingApiClient::Call::UsersMePhotoCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersMePhotoCall) } }

  describe '#put_users_me_photo' do
    subject do
      call.
        should_receive(:make_request!).
        with(:put_multipart, "v1/users/me/photo", {multipart: {photo: "/path/to/file.jpg"}}, allowed_codes: 204).
        and_return({})

      call.put_users_me_photo("/path/to/file.jpg")
    end

    its(:class) { should == Hash }
    its(:empty?) { should == true }
  end

  describe '#delete_users_me_photo' do
    subject do
      call.
        should_receive(:make_request!).
        with(:delete, "v1/users/me/photo", {}, allowed_codes: 204).
        and_return({})

      call.delete_users_me_photo()
    end

    its(:class) { should == Hash }
    its(:empty?) { should == true }
  end
end
