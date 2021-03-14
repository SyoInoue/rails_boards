class SessionsController < ApplicationController
  def new
    user = User.new
  end


  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to mypage_path
    else
      render 'home/index'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
    flash[:notice] = "ログアウトしました"
  end
end
