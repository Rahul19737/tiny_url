require 'rails_helper'

RSpec.describe "ShortUrls", type: :request do
  describe "POST /short_urls" do
    it "creates a short URL for a valid URL" do
      post "/short_urls", params: {
        url: "https://example.com"
      }

      expect(response).to have_http_status(:created)
      expect(ShortUrl.count).to eq(1)

      short_url = ShortUrl.last
      json = JSON.parse(response.body)

      expect(json["short_url"]).to include(short_url.short_code)
    end
  end
end
