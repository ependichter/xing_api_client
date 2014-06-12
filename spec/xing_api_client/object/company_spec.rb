require 'spec_helper'

describe XingApiClient::Object::User do
  subject do
    XingApiClient::Object::User.new(XingApiClient::Object::User::EXAMPLE_RESPONSE["users"].first)
  end

  its(:id) { should == '13802856_c7551a' }
  its(:first_name) { should == 'Firstname' }
  its(:last_name) { should == 'Lastname' }
  its(:display_name) { should == 'Firstname Lastname' }
  its(:page_name) { should == 'Firstname_Lastname8' }
  its(:employment_status) { should == 'EMPLOYEE' }
  its(:gender) { should == 'm' }
  its(:birth_date) { should == Date.parse("1983-01-03") }
  its(:active_email) { should == 'somemailaddress@gmail.com' }
  its(:time_zone) { should == {"utc_offset"=>2, "name"=>"Europe/Berlin"} }
  its(:premium_services) { should == ["SEARCH", "PRIVATEMESSAGES"] }
  its(:badges) { should == ["PREMIUM", "MODERATOR"] }
  its(:wants) { should == 'new gems, cool rails stuff, pizza' }
  its(:haves) { should == 'Jenkins CI, MySQL, REST, TDD, UML' }
  its(:interests) { should == 'CSS, CoffeeScript, HTML5, Robotics, jQuery' }
  its(:organisation_member) { should == nil }
  its(:languages) { should == {"en"=>"FLUENT", "de"=>"NATIVE"} }
  its(:private_address) { should be_kind_of XingApiClient::Object::Address }
  its(:business_address) { should be_kind_of XingApiClient::Object::Address }
  its(:web_profiles) { should == {} }
  its(:instant_messaging_accounts) { should == {"skype"=>"username"} }
  its(:professional_experience) { should_not be_empty }
  its(:professional_experience) { subject.professional_experience.all?{ |e| e.kind_of?(XingApiClient::Object::Company) }.should == true }
  its(:photo_urls) { should == {"large"=>"https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.140x185.jpg",
        "maxi_thumb"=>"https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.70x93.jpg",
        "medium_thumb"=>"https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.57x75.jpg",
        "mini_thumb"=>"https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.18x24.jpg",
        "thumb"=>"https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.30x40.jpg"}  }
  its(:permalink) { should == 'https://www.xing.com/profile/Firstname_Lastname8' }
end
