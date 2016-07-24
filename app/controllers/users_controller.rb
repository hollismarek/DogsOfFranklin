class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :edit]
  def index
    if current_user && current_user.is_admin
     @users = User.all
   else
     redirect_to '/login'
    end
  end

  def new
    @user = User.new
  end

  def create
    existing =
    if User.find_by email: params[:user][:email]
      flash.notice = 'That email has already been used to create an account'
      redirect_to '/signup'
    elsif User.find_by username: params[:user][:username]
      flash.notice = 'That username has already been used to create an account'
      redirect_to '/signup'
    else
      @user = User.new(user_params)
      if User.count == 0
        @user.is_admin = true
        @user.status = 'Active'
      else
        @user.is_admin = false
        @user.status = 'Pending'
      end
      if @user.save
        redirect_to '/'
      else
        redirect_to '/signup'
      end
    end
  end

  def edit
    if current_user && (current_user.is_admin || current_user = @user)
    else
      flash.notice = 'Not authorized'
      redirect_to '/login'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if session[:user_id] && session[:user_id] != params[:id].to_i
      @user = User.find(params[:id])
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to 'index', notice: 'Can not delete your own user.' }
        format.json { render json: 'Can not delete your own user.', status: :unprocessable_entity }
      end
    end
  end

  def show
  end
  
  private

    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def authorize(user)
      if user && user.is_admin || user == current_user
        @user = User.find(params[:id])
      else
        flash.notice = 'not authorized'
        redirect_to '/'
      end
    end
end
