class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def home
    @gifs = Gif.order(cached_votes_up: :desc).first(3)
    @recent = Gif.last(3).reverse
    @random = Gif.all.sample(3)
    @title = "Welcome to the Global Sign Language Dictionary"
  end

  def about
    @title = "About"
  end

  def how_it_works
    @title = "How it Works"
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
    @title = "Search"
  end

  def dashboard
    @user = User.find(params[:id])

    # @gifs = Gif.order(cached_votes_up: :desc)

    @gifs = current_user.gifs
    @favorites = @user.favorited_by_type 'Gif'
    @title = "Dashboard"
  end
end
