require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe "validations" do
    it "is invalid without an original URL" do
      short_url = ShortUrl.new(
        short_code: "abc123"
      )

      expect(short_url).not_to be_valid
      expect(short_url.errors[:original_url]).to include("can't be blank")
    end

    it "automatically generates a 6-character short code" do
      short_url = ShortUrl.new(
        original_url: "https://www.example.com"
      )

      expect(short_url.short_code).to be_nil
      expect(short_url).to be_valid
      expect(short_url.short_code.length).to eq(6)
    end

    it "generates a short code using only Base62 characters" do
      short_url = ShortUrl.new(
        original_url: "https://www.example.com"
      )

      expect(short_url).to be_valid
      expect(short_url.short_code).to match(/\A[a-zA-Z0-9]{6}\z/)
    end

    it "generates different short codes for different URLs" do
      short_url_1 = ShortUrl.new( original_url: "https://www.example.com" )
      short_url_2 = ShortUrl.new( original_url: "https://www.example.org" )

      short_url_1.valid?
      short_url_2.valid?

      expect(short_url_1.short_code).not_to eq(short_url_2.short_code)
    end

    it "is invalid with duplicate short codes" do
      short_url = ShortUrl.create!(
        original_url: "https://www.example.com"
      )

      short_url_1 = ShortUrl.new(
        original_url: "https://www.example1.com"
      )

      allow(short_url_1).to receive(:generate_short_code) do
        short_url_1.short_code = short_url.short_code
      end

      expect(short_url_1).not_to be_valid
      expect(short_url_1.errors[:short_code]).to include("has already been taken")
    end
  end
end
