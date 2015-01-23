class TracksController < ApplicationController

  before_action :ensure_logged_in

  def new
    @track = Track.new(album_id: params[:album_id])
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:notice] = @track.errors.full_messages
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:notice] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    album_id = @track.album_id
    @track.destroy!
    redirect_to album_url(album_id)
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :kind, :lyrics)
  end

  def ensure_logged_in
    if current_user.nil?
      flash[:notice] = "Must be logged-in!"
      redirect_to new_session_url
    end
  end

end
