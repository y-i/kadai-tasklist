class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    counts @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報の更新に失敗しました。'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザを削除しました'
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def correct_user
    unless current_user && current_user.id == session[:user_id]
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
