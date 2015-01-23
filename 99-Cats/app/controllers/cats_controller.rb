class CatsController < ApplicationController
  before_action :verify_cat_owner, only: [:edit, :update]

  before_action :verify_logged_in, only: [:create]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :color, :birth_date, :description, :name, :sex)
  end

  def verify_cat_owner
    @cat = Cat.find(params[:id])

    if @cat.owner_id != current_user.id
      redirect_to cats_url
    end
  end

  def verify_logged_in
    if current_user.nil?
      # flash stuff
      redirect_to new_session_url
    end
  end

end
