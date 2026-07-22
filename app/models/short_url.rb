class ShortUrl < ApplicationRecord
  before_validation :generate_short_code, on: :create

  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  private

  def generate_short_code
    self.short_code = "abc123"
  end
end
