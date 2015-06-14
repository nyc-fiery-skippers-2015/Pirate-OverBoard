class UsersController < ApplicationController
  def new
    @user = User.new
  end

 def create
    @user = User.new(user_params)
    @user.password = params[:user][:password_digest]
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = current_user
  end

  def edit
   @user = current_user
  end

  def update
   @user = current_user
   if @user.update_attributes(user_params)
     redirect_to user_path
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email)
    end
end

