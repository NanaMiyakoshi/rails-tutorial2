class SessionsController < ApplicationController
  def new
  end

  def create
    #入力されたemailを使ってデータベースからユーザーを取り出す
   user = User.find_by(email: params[:session][:email].downcase)
   #if ユーザーがデータベースにあり、かつ、認証に成功するか
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      #flash.now[:danger] = user.errors.full_messages
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
