class GifsController < ApplicationController
  def index
    @gifs = Gif.all
    authorize @gifs
  end

  def show
    @gif = Gif.find(params[:id])
    authorize @gif
  end

  def new
    @gif = Gif.new
    @gif.user = current_user
    authorize @gif if @gif.user.is_teacher

  end

  def create
    @gif = Gif.new(gif_params)
    @gif.user = current_user
    authorize @gif if @gif.user.is_teacher
    if @gif.save
      redirect_to gif_path(@gif)
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
      redirect_to gif_path(@gif)
    else
      render :new
    end
  end

  def destroy
    @gif = Gif.find(params[:id])
    @user = @gif.user
    authorize @gif
    @gif.destroy if @gif.user_id == current_user.id
    redirect_to root_path
  end

  private
  def gif_params
    params.require(:gif).permit(:title, :language, :file, :file_cache)
  end
end
