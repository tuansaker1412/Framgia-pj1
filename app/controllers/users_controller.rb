class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :correct_user, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.paginate(page: params[:page]).per_page 10
  end

  def show
     @microposts = @user.microposts.sort_feed.paginate(page: params[:page]).per_page 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:green] = "Welcome to Sky's Blog"
      redirect_to @user
    else
      flash.now[:red] = "Error"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:green] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:green] = "User deleted"
    redirect_to users_url
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:pink] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
