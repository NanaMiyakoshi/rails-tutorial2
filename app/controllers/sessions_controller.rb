class SessionsController < ApplicationController
  def new
  end

  def create
    #入力されたemailを使ってデータベースからユーザーを取り出す
   user = User.find_by(email: params[:session][:email].downcase)
   #if ユーザーがデータベースにあり、かつ、認証に成功するか
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end