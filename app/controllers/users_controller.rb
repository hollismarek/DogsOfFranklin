class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.count == 0
      @user.is_admin = true
      @user.status = 'Active'
    else
      @user.is_admin = false
      @user.status = 'Pending'
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(params[:id])
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

  private

    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
    end
end
