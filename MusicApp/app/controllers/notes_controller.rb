class NotesController < ApplicationController

  before_action :ensure_logged_in
  before_action :ensure_author, except: [:show]

  def new
    @note = Note.new(track_id: params[:track_id])
    render :new
  end

  def create
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash.now[:notice] = @note.errors.full_messages
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
    render :show
  end

  def edit
    @note = Note.find(params[:id])
    render :edit
  end

  def update
    @note = Note.find(params[:id])

    # do as before action  w head function
    if current_user.id != @note.author_id
      # bad stuffs
      raise "bad boys bad boys"
    end

    if @note.update(note_params)
      redirect_to track_url(@note.track_id)
    else
      flash.now[:notice] = @note.errors.full_messages
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if current_user.id != @note.author_id
      # bad stuffs
      raise "bad boys bad boys"
    end

    track_id = @note.track_id
    @note.destroy!
    redirect_to track_url(track_id)
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end

  def ensure_logged_in
    if current_user.nil?
      flash[:notice] = "Must be logged-in!"
      redirect_to new_session_url
    end
  end

  def ensure_author
    @note = Note.find(params[:id])
  end

end
