require "securerandom"

class ShortUrl < ApplicationRecord
  BASE62_ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

  before_validation :generate_short_code, on: :create

  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  private

  def generate_short_code
    self.short_code = 6.times.map do 
      BASE62_ALPHABET[SecureRandom.random_number(BASE62_ALPHABET.length)]
    end.join
  end
end
