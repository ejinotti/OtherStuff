class CatRentalRequestsController < ApplicationController

  before_action :verify_cat_owner, only: [:approve, :deny]
  before_action :verify_request_owner, only: [:edit, :update]
  before_action :verify_logged_in, only: [:create]

  def index
    @requests = CatRentalRequest.all
    render :index
  end

  def show
    @request = CatRentalRequest.find(params[:id])
    render :show
  end

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)

    @request.user_id = current_user.id

    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @request.update(request_params)
      redirect_to cat_rental_request_url(@request)
    else
      render :edit
    end
  end

  def approve
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  def destroy
  end

private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

  def verify_cat_owner
    @request = CatRentalRequest.find(params[:id])

    if @request.cat.owner.id != current_user.id
      # flash some nasty message
      redirect_to cats_url
    end
  end

  def verify_request_owner
    @request = CatRentalRequest.find(params[:id])

    if @request.user_id != current_user.id
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
