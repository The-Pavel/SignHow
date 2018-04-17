class GifsController < ApplicationController
  def index
    @gifs = Gif.all
  end

  def show
    @gif = Gif.find(params[:id])
  end

  def new
    @gif = Gif.new
    @gif.user = current_user
  end

  def create
    @gif = Gif.new(gif_params)
    @gif.user = current_user
    if @gif.save
      redirect_to gif_path(@gif)
    else
      render :new
    end
  end

  def edit
    @gif = Gif.find(params[:id])
  end

  def update
    @gif = Gif.find(params[:id])
    if @gif.update(gif_params)
      redirect_to gif_path(@gif)
    else
      render :new
    end
  end

  def destroy
    @gif = Gif.find(params[:id])
    @user = @gif.user
    @gif.destroy
    redirect_to root_path
  end

  private
  def gif_params
    params.require(:gif).permit(:title, :language, :file, :file_cache)
  end
end
