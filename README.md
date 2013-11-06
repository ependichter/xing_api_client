# XingApiClient
The main goal of this Gem is to provide an easy access to the XING API. The XING API uses the OAuth1 standard for the access management and offers calls to access data and functions from user accounts. This Gem encapsulates both by providing methods to handle it in a high level way.

Special thanks go to [Jan-Oliver Jahner (jojahner)](https://github.com/jojahner) and [Björn Jensen (mirouhh)](https://github.com/mirouhh).

## Requirements

Tested with ruby 1.9.3p448 and 2.0.0-p0.

[![Coverage Status](https://coveralls.io/repos/ependichter/xing_api_client/badge.png?branch=master)](https://coveralls.io/r/ependichter/xing_api_client)
[![Build Status](https://api.travis-ci.org/ependichter/xing_api_client.png?branch=master)](http://travis-ci.org/ependichter/xing_api_client)

## Quickstart
### Make a handshake
```ruby
# Require the Gem
require('xing_api_client')

# Get a consumer key and secret from https://dev.xing.com/applications and set up the configuration
XingApiClient::Config.set(consumer_key: '12345', consumer_secret: 'abcde')

# Initialize the handshake
request_params = XingApiClient.request_params
puts "Use your browser to open #{request_params[:auth_url]}"

# Verify the pin
puts "Please enter the pin:"
pin = gets.chomp.strip

# Authorize the handshake and get the token and secret
authorized_params = XingApiClient.authorize(request_params[:request_token], pin)
puts authorized_params.inspect # { access_token: 'abcde', secret: '12345' }

# Initialize a client
client = XingApiClient.new(authorized_params[:access_token], authorized_params[:secret])

# Make a request to load your user data
puts client.request.get_users.inspect
```

## Before you start
To get access to the XING API, you need a consumer key and a consumer secret. To get those you have to login to the Dev-Portal http://dev.xing.com and create a new app. Now you have a test-consumer-key which can use all calls that are listed in the documentation https://dev.xing.com/docs/resources .
After you have developed your app, you can request a production-consumer-key by using the ‘Get a production key’-Button on the app management site (https://dev.xing.com/applications).

## Configuration
The default configuration:

```ruby
{
  host: 'https://api.xing.com',
  request_token_path: '/v1/request_token',
  authorize_path: '/v1/authorize',
  access_token_path: '/v1/access_token',
  consumer_key: nil,
  consumer_secret: nil,
  callback_url: nil # The callback URL for the pin. If it is blank, you user hat to enter the pin manually
}
```

You can add/overwrite configuration values in four different ways:

### Use a Hash
```ruby
XingApiClient::Config.set(consumer_key: '12345', host: 'abcde')
```

### Use a YAML-File
```ruby
XingApiClient::Config.load_file('path/config.yml')
```

### Use Environment variables

```ruby
XingApiClient::Config.load_env
```

Loads this enviroment variables:
- XINGAPICLIENT_HOST
- XINGAPICLIENT_REQUEST_TOKEN_PATH
- XINGAPICLIENT_AUTHORIZE_PATH
- XINGAPICLIENT_ACCESS_TOKEN_PATH
- XINGAPICLIENT_CONSUMER_KEY
- XINGAPICLIENT_CONSUMER_SECRET
- XINGAPICLIENT_CALLBACK_URL

If you set a prefix, it replaces the part 'XINGAPICLIENT'. Empty values will be ignored.

### Paste some values to the initialization
```ruby
configuration_values = {
  consumer_key: '12345',
  consumer_secret: 'abcde',
}

XingApiClient.new('access_token', 'access_token_secret', configuration_values)
```

Here are only the values 'consumer_key' and 'consumer_secret' available.

## Handshake
Before you can start using the gem you need to make the handshake for every developer. There are two different ways:

### Pin
The user has to enter the pin manually if no callback URL is configured.
```ruby
# Get a consumer key and secret from https://dev.xing.com/applications and set up the configuration
XingApiClient::Config.set(consumer_key: '12345', consumer_secret: 'abcde')

# Initialize the handshake
request_params = XingApiClient.request_params
puts "Use your browser to open #{request_params[:auth_url]}"

# Verify the pin
puts "Please enter the pin:"
pin = gets.chomp.strip

# Authorize the handshake and get the token and secret
authorized_params = XingApiClient.authorize(request_params[:request_token], pin)
puts authorized_params.inspect # { access_token: 'abcde', secret: '12345' }
```

### Callback
If a callback URL is defined this will be use to send the pin as a parameter.

```ruby
# Get a consumer key and secret from https://dev.xing.com/applications and set up the configuration
XingApiClient::Config.set(consumer_key: '12345', consumer_secret: 'abcde')

request_params = XingApiClient.request_params

# You need to save the token somewhere
session[:token] = request_params[:request_token]

# Initialize the handshake
redirect_to request_params[:auth_url]
```

The user gets redirected to the handshake dialog. After he has accepted the handshake the url cets called with the parameter 'oauth_verifier' witch contains the pin.

```ruby
authorized_params =  XingApiClient.authorize(session[:token], params[:oauth_verifier])
puts authorized_params.inspect # { access_token: 'abcde', secret: '12345' }
```


## Make calls
After setting up the configuration and making the handshake you can make calls in the scope of the user.

```ruby
# Don't forget to configurate your client before you initialize an object

client = XingApiClient.new('ACCESS_TOKEN', 'SECRET')
client.request.call_methods.keys # [:get_users, :get_users_contact_requests, :get_users_contacts, ...]
client.request.get_users(id: 'me')
```

## Available calls
### User Profiles
- [x] GET /v1/users/:id
- [x] GET /v1/users/me
- [x] GET /v1/users/me/id_card
- [x] GET /v1/users/find_by_emails

### Jobs
- [ ] ~~GET /v1/jobs/:id (experimental)~~
- [ ] ~~GET /v1/jobs/find (experimental)~~
- [ ] ~~GET /v1/users/:user_id/jobs/recommendations (experimental)~~

### Messages
- [ ] GET /v1/users/:user_id/conversations
- [ ] POST /v1/users/:user_id/conversations
- [ ] ~~GET /v1/users/me/conversations/valid_recipients/:id (experimental)~~
- [ ] GET /v1/users/:user_id/conversations/:id
- [ ] ~~GET /v1/user…ations/:conversation_id/attachments (experimental)~~
- [ ] ~~GET /v1/user…ns/:conversation_id/attachments/:id (experimental)~~
- [ ] ~~POST /v1/user…rsation_id/attachments/:id/download (experimental)~~
- [ ] PUT /v1/users/:user_id/conversations/:id/read
- [ ] ~~PUT /v1/user…s/:conversation_id/participants/:id (experimental)~~
- [ ] GET /v1/user…ersations/:conversation_id/messages
- [ ] GET /v1/user…tions/:conversation_id/messages/:id
- [ ] PUT /v1/user…/:conversation_id/messages/:id/read
- [ ] DELETE /v1/user…/:conversation_id/messages/:id/read
- [ ] POST /v1/user…ersations/:conversation_id/messages
- [ ] DELETE /v1/users/:user_id/conversations/:id

### Profile Messages
- [x] GET /v1/users/:user_id/profile_message
- [x] PUT /v1/users/:user_id/profile_message

### Contacts
- [x] GET /v1/users/:user_id/contacts
- [ ] ~~GET /v1/users/me/contact_ids (experimental)~~
- [x] GET /v1/users/:user_id/contacts/:contact_id/tags
- [x] GET /v1/users/:user_id/contacts/shared

### Contact Requests
- [x] GET /v1/users/:user_id/contact_requests
- [x] POST /v1/users/:user_id/contact_requests
- [x] DELETE /v1/users/:user_id/contact_requests/:id
- [x] GET /v1/users/:user_id/contact_requests/sent
- [x] PUT /v1/users/:user_id/contact_requests/:id/accept

### Contact Path
- [x] GET /v1/users/:user_id/network/:other_user_id/paths

### Bookmarks
- [x] GET /v1/users/:user_id/bookmarks
- [x] PUT /v1/users/:user_id/bookmarks/:id
- [x] DELETE /v1/users/:user_id/bookmarks/:id

### Network Feed
- [ ] GET /v1/users/:user_id/network_feed
- [ ] GET /v1/users/:id/feed
- [ ] POST /v1/users/:id/status_message
- [ ] ~~POST /v1/users/me/share/link (experimental)~~
- [ ] GET /v1/activities/:id
- [ ] POST /v1/activities/:id/share
- [ ] DELETE /v1/activities/:id
- [ ] GET /v1/activities/:activity_id/comments
- [ ] POST /v1/activities/:activity_id/comments
- [ ] DELETE /v1/activities/:activity_id/comments/:id
- [ ] GET /v1/activities/:activity_id/likes
- [ ] PUT /v1/activities/:activity_id/like
- [ ] DELETE /v1/activities/:activity_id/like

### Profile Visits
- [x] GET /v1/users/:user_id/visits
- [x] POST /v1/users/:user_id/visits

### Recommendations
- [ ] GET /v1/users/:user_id/network/recommendations
- [ ] DELETE /v1/users/:user_id/network/recommendations/user/:id

### Invitations
- [ ] ~~POST /v1/users/invite (experimental)~~

### Geo Locations
- [ ] GET /v1/users/:user_id/nearby_users
- [ ] PUT /v1/users/:user_id/geo_location


