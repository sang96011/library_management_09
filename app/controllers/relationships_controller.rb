class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @user = User.find params[:followed_id]
    if @user
      current_user.follow(@user)
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "controllers.relationship.danger"
      redirect_to root_url
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if @user
      current_user.unfollow(@user)
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "controllers.relationship.danger"
      redirect_to root_url
    end
  end
end
