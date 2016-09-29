class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
  end

  def update
    task = Task.find(params[:id])
    task.completed_at=DateTime.now
    task.save
    redirect_to action: "show", id: params[:id]
  end

  def show
    @task = Task.find(params[:id].to_i)
  end

  def create
    Task.create(title: params[:title], description: params[:description])
    redirect_to action: "index"
  end

  def edit
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to action: "index"
  end
end
