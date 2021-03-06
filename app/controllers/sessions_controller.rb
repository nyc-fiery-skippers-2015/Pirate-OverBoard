class SessionsController < ApplicationController
   def new
    @user = User.new
   end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password_digest])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end


