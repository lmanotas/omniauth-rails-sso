require 'spec_helper'

describe OmniAuth::Strategies::RailsSso do

  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  let(:app) {
    lambda do
      [200, {}, ["Hello."]]
    end
  }

  let(:raw_info) {
    { 'uid' => '123', 'email' => 'sample@test.com' }
  }

  subject do
    OmniAuth::Strategies::RailsSso.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) { request }
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    context "default options" do
      it 'has correct rails-sso site' do
        expect(subject.client.site).to eq('https://sso.rails-sso.com')
      end

      it 'has correct authorize url' do
        expect(subject.client.options[:authorize_url]).to eq('/oauth/authorize')
      end

      it 'has correct request token url' do
        expect(subject.client.options[:token_url]).to eq('/oauth/token')
      end
    end

    context "option overrides" do
      it 'should allow overriding the site' do
        @options = { client_options: {'site' => 'https://example.com'}}
        expect(subject.client.site).to eq('https://example.com')
      end

      it 'should allow overriding the authorize_url' do
        @options = { client_options: {'authorize_url' => 'https://example.com'}}
        expect(subject.client.options[:authorize_url]).to eq('https://example.com')
      end

      it 'should allow overriding the token_url' do
        @options = { client_options: {'token_url' => 'https://example.com'}}
        expect(subject.client.options[:token_url]).to eq('https://example.com')
      end
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      expect(subject.callback_path).to eq('/auth/rails_sso/callback')
    end
  end

  describe '#uid' do
    before :each do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    it 'returns the uid from raw_info' do
      expect(subject.uid).to eq('123')
    end
  end

  describe '#info' do
    before :each do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    context 'when data is present in raw info' do
      it 'returns the email' do
        expect(subject.info[:email]).to eq('sample@test.com')
      end
    end
  end

  describe '#extra' do
    let(:client) do
      OAuth2::Client.new('abc', 'def') do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/me') {|env| [200, {'content-type' => 'application/json'}, '{"sub": "12345"}']}
        end
      end
    end

    let(:access_token) { OAuth2::AccessToken.from_hash(client, {}) }

    before { allow(subject).to receive(:access_token).and_return(access_token) }

    it 'returns a Hash' do
      expect(subject.extra).to be_a(Hash)
    end
  end
end