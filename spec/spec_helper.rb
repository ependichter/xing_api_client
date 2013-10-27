require 'rubygems'
require 'bundler/setup'
require 'coveralls'
require 'simplecov'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start { add_filter('spec') }

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xing_api_client'


RSpec.configure do |config|
  # some (optional) config here
end

XingApiClient::Object::User::EXAMPLE_RESPONSE = {
  "users" => [
    {
      "id" => "13802856_c7551a",
      "first_name" => "Firstname",
      "last_name" => "Lastname",
      "display_name" => "Firstname Lastname",
      "page_name" => "Firstname_Lastname8",
      "employment_status" => "EMPLOYEE",
      "gender" => "m",
      "birth_date" => {
        "day" => 3,
        "month" => 1,
        "year" => 1983
      },
      "active_email" => "somemailaddress@gmail.com",
      "time_zone" => {
        "utc_offset" => 2,
        "name" => "Europe/Berlin"
      },
      "premium_services" => [
        "SEARCH",
        "PRIVATEMESSAGES"
      ],
      "badges" => [
        "PREMIUM",
        "MODERATOR"
      ],
      "wants" => "new gems, cool rails stuff, pizza",
      "haves" => "Jenkins CI, MySQL, REST, TDD, UML",
      "interests" => "CSS, CoffeeScript, HTML5, Robotics, jQuery",
      "organisation_member" => nil,
      "languages" => {
        "en" => "FLUENT",
        "de" => "NATIVE"
      },
      "private_address" => {
        "street" => "Somewhere Str. 85",
        "zip_code" => "20756",
        "city" => "Hamburg",
        "province" => "Hamburg",
        "country" => "DE",
        "email" => "somemailaddress@gmail.com",
        "phone" => nil,
        "fax" => nil,
        "mobile_phone" => "49|111|2222222222"
      },
      "business_address" => {
        "street" => "Somewhere Str. 85",
        "zip_code" => "20756",
        "city" => "Hamburg",
        "province" => "Hamburg",
        "country" => "DE",
        "email" => "somemailaddress@gmail.com",
        "phone" => nil,
        "fax" => nil,
        "mobile_phone" => nil
      },
      "web_profiles" => {},
      "instant_messaging_accounts" => {
        "skype" => "username"
      },
      "professional_experience" => {
        "primary_company" => {
          "name" => "COMPANY AG",
          "url" => "https://www.company.com",
          "tag" => "COMPANYAG",
          "company_size" => "501-1000",
          "industry" => "INTERNET",
          "title" => "Engineer",
          "career_level" => nil,
          "description" => "",
          "begin_date" => "2013-04",
          "end_date" => nil
        },
        "non_primary_companies" => [
        ],
        "awards" => []
      },
      "educational_background" => {
        "qualifications" => [
        ],
        "schools" => [
        ]
      },
      "photo_urls" => {
        "large" => "https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.140x185.jpg",
        "maxi_thumb" => "https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.70x93.jpg",
        "medium_thumb" => "https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.57x75.jpg",
        "mini_thumb" => "https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.18x24.jpg",
        "thumb" => "https://x1.xingassets.com/img/users/3/5/1/238ddffce.13802856,9.30x40.jpg"
      },
      "permalink" => "https://www.xing.com/profile/Firstname_Lastname8"
    }
  ]
}
