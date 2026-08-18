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

  describe "GET /:short_code" do
    it "redirects to the original URL" do
      short_url = ShortUrl.create!(
        original_url: "https://www.example.com"
      )

      get "/#{short_url.short_code}"

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(short_url.original_url)
    end

    it "returns not found for an unknown short code" do
      get "/doesnotexist"

      expect(response).to have_http_status(:not_found)
    end
  end
end
