class XingApiClient
  module Call
    module UsersMePhotoCall
      def put_users_me_photo(photo_path)
        make_request!(:put_multipart, "v1/users/me/photo", {multipart: { photo: photo_path }}, allowed_codes: 204)
      end

      def delete_users_me_photo
        make_request!(:delete, "v1/users/me/photo", {}, allowed_codes: 204)
      end
    end
  end
end
