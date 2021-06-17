class MagicController < ApplicationController
  include ActionController::Cookies

  DEFAULT_ORIGIN = 'https://smile.io'
  CHANNEL_URLS = {
    'channel_1' => 'https://shopify.com',
    'channel_2' => 'https://wix.com'
  }.freeze

  def create
    set_cors_common_headers

    cookies[:smile_cookie] = {
      value: 'chocochip',
      same_site: :none,
      domain: 'smile.io',
      secure: true
    }

    head :ok
  end

  def preflight
    set_cors_preflight_headers
    head :no_content
  end

  private

  def origin_for(channel:)
    CHANNEL_URLS[channel] || 'https://smile.io'
  end

  def set_cors_preflight_headers
    set_cors_common_headers
    headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Smile-Channel-Key'
  end


  def set_cors_common_headers
    channel = request.headers['HTTP_SMILE_CHANNEL_KEY']
    headers['Access-Control-Allow-Origin'] = origin_for(channel: channel)
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Vary'] = 'Origin, Smile-Channel-Key'
  end
end
