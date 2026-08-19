class ShortUrlsController < ApplicationController
  def create
    short_url = ShortUrl.create!(
        original_url: short_url_params[:url]
    )

    render json: {
        short_url: short_url.short_code
    }, status: :created
  end

  def show
    short_url = ShortUrl.find_by!(short_code: params[:short_code])

    redirect_to short_url.original_url, allow_other_host: true
  end

  private

  def short_url_params
    params.permit(:url)
  end
end
