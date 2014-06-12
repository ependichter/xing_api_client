require "oauth"
require 'json'
require 'open-uri'
require 'yaml'
require 'ostruct'
require 'faraday_middleware'
require 'active_support/core_ext/hash/indifferent_access'
%w{ version config object call request}.each{ |name| require_relative "xing_api_client/#{name}"}

class XingApiClient
  include Config
  extend Config

  def initialize(access_token, secret, options = {})
    @access_token  = access_token
    @secret        = secret
    @consumer      = self.class.consumer(options)
  end

  def self.request_params
    oauth_params = {}
    oauth_params.merge!(oauth_callback: config.callback_url) if config.callback_url

    token = consumer.get_request_token(oauth_params)

    { request_token: token, auth_url: token.authorize_url }
  end

  def self.authorize(token, pin)
    access_token = token.get_access_token(oauth_verifier: pin)

    { access_token: access_token.token, secret: access_token.secret }
  end

  def request
    Request.new(connection)
  end

  def self.consumer(options = {})
    consumer_key    = options[:consumer_key]    || config.consumer_key
    consumer_secret = options[:consumer_secret] || config.consumer_secret

    ::OAuth::Consumer.new(consumer_key, consumer_secret, {
      :site => config.host,
      :request_token_path => config.request_token_path,
      :authorize_path => config.authorize_path,
      :access_token_path => config.access_token_path
    })
  end

private
  def consumer_token
    OAuth::ConsumerToken.new(@consumer, @access_token, @secret)
  end

  def connection
    Faraday.new(:url => config.host) do |faraday|
      faraday.request :multipart
      faraday.request :json
      faraday.request(:oauth, {
                                consumer_key: config.consumer_key,
                                consumer_secret: config.consumer_secret,
                                token: @access_token,
                                token_secret: @secret
                              }
      )
      faraday.response :logger if config.debug
      faraday.adapter  Faraday.default_adapter
    end
  end
end
