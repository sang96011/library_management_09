class FollowsController < ApplicationController
  def index
    @follows = Follow.all
  end

  def new
    @follow = Follow.new
  end

  def create
    @follow = current_user.follows.build target_id: params[:target_id],
      target_type: params[:target_type]
    if @follow.save
      flash[:notice] = t ".followed"
    else
      flash[:notice] = t ".follow_fail"
    end
  end

  def destroy
    follow = Follow.find_by(target_id: params[:target_id],
      target_type: params[:target_type], user_id: current_user.id)
    if follow && follow.destroy
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
end
