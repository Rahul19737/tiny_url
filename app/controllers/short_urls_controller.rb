class ShortUrlsController < ApplicationController
  def create
    short_url = ShortUrl.create!(
        original_url: short_url_params[:url]
    )

    render json: {
        short_url: short_url.short_code
    }, status: :created
  end

  private

  def short_url_params
    params.permit(:url)
  end
end
