require 'spec_helper'

require 'open-uri'
require 'openssl'

def fetch(path)
  url = ENV.fetch('BASE_URL') + path
  yield open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
rescue OpenURI::HTTPError => error
  yield error.io
end

describe 'tdkexample' do
  it 'doubles the given value' do
    fetch('/double/10') do |response|
      status_code = response.status[0].to_i
      content = response.read.to_i

      expect(status_code).to eq(200)
      expect(content).to eq(20)
    end
  end

  it 'halves the given value' do
    fetch('/half/10') do |response|
      status_code = response.status[0].to_i
      content = response.read.to_i

      expect(status_code).to eq(200)
      expect(content).to eq(5)
    end
  end
end
