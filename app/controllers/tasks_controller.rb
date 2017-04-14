class TasksController < ApplicationController
  def index
    @tasks = Task.all
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
      flash.now[:error] = 'タスクの更新に失敗しました'
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
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスクを登録しました'
      redirect_to @task
    else
      flash.now[:error] = 'タスクの登録に失敗しました'
      render :edit
    end
  end

  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
