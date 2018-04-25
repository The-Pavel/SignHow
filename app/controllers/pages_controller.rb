class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def home
    @gifs = Gif.order(cached_votes_up: :desc).last(6)
  end

  def search
    if params[:query].present? || params[:query_language].present?
      sql_query = "title ILIKE :query"
      sql_query_language = "language ILIKE :query_language"
      @gifs = Gif.where("title ILIKE ?" , "%#{params[:query]}%").where("language ILIKE ?", "%#{params[:query_language]}%").order(cached_votes_up: :desc)
    else
      @gifs = Gif.order(cached_votes_up: :desc)
    end
    @query = params[:query]
    @query_language = params[:query_language]
  end

  def dashboard
    @user = User.find(params[:id])
    @gifs = Gif.where('gifs.user_id = ?', current_user.id)
    @favorites = @user.favorited_by_type 'Gif'
  end
end
