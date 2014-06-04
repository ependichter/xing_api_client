require 'spec_helper'

describe XingApiClient::Call::UsersNetworkRecommendationsCall do
  let(:call) { Object.new.tap{ |object| object.extend(XingApiClient::Call::UsersNetworkRecommendationsCall) } }

  describe '#get_users_network_recommendations' do
    context 'with no options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/network/recommendations", {:user_id=>"me", :user_fields=>nil, :limit=>100, :offset=>nil}, {:array_keys=>"user_recommendations"}).
          and_return({ "recommendations" => [], "total" => 0 })

        call.get_users_network_recommendations()
      end

      its(:class) { should == Array }
    end

    context 'with all options' do
      subject do
        call.
          should_receive(:make_request!).
          with(:get, "v1/users/me/network/recommendations", {:user_id=>"me", :user_fields=>nil, :since=>"123456_abcdef", :limit=>"99", :offset=>"30"}, {:array_keys=>"user_recommendations"}).
          and_return({ "recommendations" => [], "total" => 0 })

        call.get_users_network_recommendations(offset: '30', limit: '99', similar_user_id: '123456_abcdef',user_fields: [:id, :page_name])
      end

      its(:class) { should == Array }
    end
  end

  describe '#get_users_network_recommendations' do
    subject do
      call.
        should_receive(:make_request!).
        with(:delete, "v1/users/me/network/recommendations/some-123456_abcdef", {}, {:allowed_codes=>204}).
        and_return(nil)

      call.delete_users_network_recommendations('some-123456_abcdef')
    end

    its(:class) { should == NilClass }
  end
end
