class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :admin?, only: :make_admin

  def show
    @user = User.find_by id: params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t ".welcome"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @user = User.find_by id: params[:id]
    @users = User.search(params[:query]).newest._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @users.to_xls}
    end
  end

  def edit; end

  def update
    return render :edit unless @user.update_attributes user_params
    flash[:success] = t ".updated"
    redirect_to users_path
  end

  def make_admin
    @user.update_attribute(:admin, true)
    flash[:success] = t ".made_admin"
    redirect_to users_path
  end

   def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:info] = t ".cant_find"
    redirect_to signup_path
  end
end
