class AlbumsController < ApplicationController

  before_action :ensure_logged_in

  def new
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:notice] = @album.errors.full_messages
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:notice] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    band_id = @album.band_id
    @album.destroy!
    redirect_to band_url(band_id)
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :style)
  end

  def ensure_logged_in
    if current_user.nil?
      flash[:notice] = "Must be logged-in!"
      redirect_to new_session_url
    end
  end

end
