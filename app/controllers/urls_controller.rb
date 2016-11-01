class UrlsController < ApplicationController
  def index
    redirect_to root_path
  end

  def new
    @item = Url.new
  end

  def create
    @item = Url.new(permited_params)
    if @item.save
      flash['success'] = 'Shortned successfully'
      redirect_to url_path(@item.key)
    else
      render :new
    end
  end

  def show
    @item = Url.find_by_key params[:id]
    if @item
      @short_url = "#{request.base_url}/#{@item.key}"
    else
      render :not_found
    end
  end

  def redirect
    url = Url.find_by_key params[:key]
    if url
      url.increment!(:redirects)
      redirect_to url.original, status: 301
    else
      render :not_found
    end
  end

  private

  def permited_params
    params.require(:url).permit(:original)
  end
end
