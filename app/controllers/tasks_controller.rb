class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.all
  end
  def show
    @task = Task.find(params[:id])
  end
  def new
    @task = Task.new
  end
  def edit
    @task = Task.find(params[:id])
  end
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to tasks_url
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを登録しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの登録に失敗しました'
      render :edit
    end
  end

  private

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
