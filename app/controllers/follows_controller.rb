class FollowsController < ApplicationController
  before_action :load_follow, only: :destroy
  load_and_authorize_resource

  def index
    @follows = Follow.all
  end

  def new
    @follow = Follow.new
  end

  def create
    @follow = current_user.follows.build follow_params
    if @follow.save
      flash[:notice] = t ".followed"
    else
      flash[:notice] = t ".follow_fail"
    end
  end

  def destroy
    if @follow&.destroy
      flash[:notice] = t ".unfollowed"
    else
      flash[:notice] = t ".unfollow_fail"
    end
  end

  def show
    @follow = Follow.find_by id: params[:id]
    return if @follow
    flash[:danger] = t ".show_follow"
  end

  private

  def follow_params
    params.require(:follow).permit :user_id, :target_id, :target_type
  end

  def load_follow
    @follow = Follow.find_by follow_params
    return if @follow
    flash[:danger] = ".not_found"
    redirect_to root_path
  end
end
