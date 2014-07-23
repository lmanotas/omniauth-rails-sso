require 'omniauth-oauth2'
require "omniauth/rails_sso/version"

module OmniAuth
  module Strategies
    class RailsSso < OmniAuth::Strategies::OAuth2

      option :name, "rails_sso"
      option :client_options, {
        site: 'https://sso.rails-sso.com'
      }

      uid { raw_info['uid'] }

      info do
        { email: raw_info['email'] }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get("/me").parsed
      end
    end
  end
end