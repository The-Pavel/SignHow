class GifsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  # def tagged
    # if params[:tag].present?
      # @tags = Gif.tagged_with(params[:tag_list], :any => true)
    # else
      # @gifs = Gif.all
    # end
  # end

  def upvote
    @gif = Gif.find(params[:id])
    @gif.upvote_from current_user
    authorize @gif
      if current_user.voted_for? @gif
        respond_to do |format|
          format.html { redirect_to gif_path(@gif) }
          format.js { render 'voted' }
        end
      else
        respond_to do |format|
          format.html { render 'gifs/show' }
          format.js { render 'voted' }
        end
      end
  end

  def downvote
    @gif = Gif.find(params[:id])
    @gif.downvote_from current_user
    authorize @gif
      if current_user.voted_as_when_voted_for @gif
        respond_to do |format|
          format.html { redirect_to gif_path(@gif) }
          format.js { render 'voted' }
        end
      else
        respond_to do |format|
          format.html { render 'gifs/show' }
          format.js { render 'voted' }
        end
      end
  end

  def favorite
    @gif = Gif.find(params[:id])
    current_user.favorite @gif
    authorize @gif
      if @gif.favorited
        respond_to do |format|
          format.html { redirect_to gif_path(@gif) }
          format.js { render 'favorite' }
        end
      else
        respond_to do |format|
          format.html { render 'gifs/show' }
          format.js { render 'favorite' }
        end
      end
  end

  def unfavorite
    @gif = Gif.find(params[:id])
    current_user.favorite(@gif).destroy
    authorize @gif
      if !@gif.favorited
        respond_to do |format|
          format.html { redirect_to gif_path(@gif) }
          format.js { render 'favorite' }
        end
      else
        respond_to do |format|
          format.html { render 'gifs/show' }
          format.js { render 'favorite' }
        end
      end
  end

  def index
    @gifs = Gif.last(3)
    authorize @gifs
  end

  def show
    @gif = Gif.find(params[:id])
    @gifs = @gif.find_related_tags.to_a
    authorize @gif
    @title = "Signs"
  end

  def new
    @gif = Gif.new
    @gif.user = current_user
    authorize @gif
    @title = "Add a Sign"
  end

  def create
    @gif = Gif.new(gif_params)
    @gif.user = current_user
    authorize @gif
    if @gif.save
      redirect_to dashboard_path(current_user)
    else
      render :new
    end
  end

  def edit
    @gif = Gif.find(params[:id])
    authorize @gif if @gif.user_id == current_user.id
  end

  def update
    @gif = Gif.find(params[:id])
    authorize @gif if @gif.user_id == current_user.id
    if @gif.update(gif_params)
      redirect_to dashboard_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @gif = Gif.find(params[:id])
    @user = @gif.user
    authorize @gif
    @gif.destroy if @gif.user_id == current_user.id
    redirect_to dashboard_path(current_user)
  end

  private
  def gif_params
    params.require(:gif).permit(:title, :language, :file, :file_cache, :tag_list)
  end
end
