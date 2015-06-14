class UsersController < ApplicationController
  def new
    @user = User.new
  end

 def create
    @user = User.new(user_params)
    # binding.pry
    @user.password = params[:user][:password_digest]
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
   @user = User.find_by(id: params[:id])
  end

  def update
   @user = User.findy_by(id: params[:id])
   if @user.update_attreibutes(user_params)
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

