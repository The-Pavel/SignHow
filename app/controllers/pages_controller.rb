class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def home
    @gifs = Gif.all
  end

  def search
    if params[:query].present? || params[:query_language].present?
      sql_query = "title ILIKE :query"
      sql_query_language = "language ILIKE :query_language"
      @gifs = Gif.where("title ILIKE ?" , "#{params[:query]}%").or(Gif.where("language ILIKE ?" , "%#{params[:query_language]}%"))
    else
      @gifs = Gif.all
    end
    @query = params[:query]
    @query_language = params[:query_language]
  end

end
