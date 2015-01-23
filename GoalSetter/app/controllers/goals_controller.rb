class GoalsController < ApplicationController

  before_action :ensure_signed_in

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    raise "bad stuff" if @goal.nil?

    if @goal.update(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy!
    redirect_to user_url(current_user)
  end

  def add_cheers
    @goal = Goal.find(params[:id])
    user = current_user

    if user.cheers > 0
      @goal.cheers += 1
      user.cheers -= 1
      @goal.save!
      user.save!
    else
      flash[:errors] = ["You don't have any cheers left to give!"]
    end
    redirect_to user_url(@goal.user)
  end

  private

  def goal_params
    params.require(:goal).permit(:objective, :privacy, :completed)
  end
end
