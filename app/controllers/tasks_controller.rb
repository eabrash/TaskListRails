class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
  end

  def update
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
