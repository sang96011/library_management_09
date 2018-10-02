class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "users.controller.create.welcome"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @users = User.newest.paginate(page: params[:page],
      per_page: Settings.user.index.per_page)
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:info] = t "users.controller.load.no_user"
    redirect_to signup_path
  end
end
