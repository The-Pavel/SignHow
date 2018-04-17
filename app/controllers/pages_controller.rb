class PagesController < ApplicationController

  skip_before_action :authenticate_user!
  
  def home
    @gifs = Gif.all
  end

  def search
    if params[:query].present?
      sql_query = "title ILIKE :query OR language ILIKE :query"
      @gifs = Gif.where(sql_query, query: "%#{params[:query]}%")
    else
      @gifs = Gif.all
    end
    @query = params[:query]
  end

end
