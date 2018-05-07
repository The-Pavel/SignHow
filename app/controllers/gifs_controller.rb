require 'tempfile'

class GifsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def tagged
    if params[:tag].present?
      @gifs = Gif.paginate(page: params[:page], per_page: 9).tagged_with(params[:tag]).order(cached_votes_up: :desc)
    else
      @gifs = Gif.paginate(page: params[:page], per_page: 9).all.order(cached_votes_up: :desc)
    end
    authorize @gifs
  end

  def upvote
    @gif = Gif.find(params[:id])
    @gif.upvote_from current_user
    authorize @gif
      if current_user.voted_for? @gif
        respond_to do |format|
          format.html { redirect_to request.referrer }
          format.js { render 'voted' }
        end
      else
        respond_to do |format|
          format.html { redirect_to request.referrer }
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
          format.html { redirect_to request.referrer }
          format.js { render 'voted' }
        end
      else
        respond_to do |format|
          format.html { redirect_to request.referrer }
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
          format.html { redirect_to request.referrer }
          format.js { render 'favorite' }
        end
      else
        respond_to do |format|
          format.html { redirect_to request.referrer }
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
    # gif_tag = @gif.tags.name.to_a
    # @related_gifs = Gif.tagged_with(gif_tag, :any => true)
    @gifs = @gif.find_related_tags.to_a.first(4)
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
    if @gif.file.path[-3..-1] == 'gif'
      if @gif.save
        redirect_to dashboard_path(current_user)
      else
        render :new
      end
    else
      file = Tempfile.new('foo')
      file.close
      file_name = Gif.last.id + 1
      `ffmpeg -i #{@gif.file.path} -s 270x250 ./public/#{file_name}.gif`
      @gif.file = File.open("./public/#{file_name}.gif")
      if @gif.save
        File.delete("./public/#{file_name}.gif")
        file.unlink
        redirect_to dashboard_path(current_user)
      else
        render :new
      end
    end

    rescue Cloudinary::CarrierWave::UploadError
      render plain: "File size too large. Please reduce video size and try again."
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
      render :edit
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
