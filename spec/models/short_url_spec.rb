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

    it "is invalid without a short code" do
      short_url = ShortUrl.new(
        original_url: "https://www.example.com"
      )

      expect(short_url).not_to be_valid
      expect(short_url.errors[:short_code]).to include("can't be blank")
    end

    it "is invalid with duplicate short codes" do
      short_url = ShortUrl.create!(
        original_url: "https://www.example.com",
        short_code: "abc123"
      )

      short_url_1 = ShortUrl.new(
        original_url: "https://www.example1.com",
        short_code: "abc123"
      )

      expect(short_url).to be_valid
      expect(short_url_1).not_to be_valid
      expect(short_url_1.errors[:short_code]).to include("has already been taken")
    end
  end
end
