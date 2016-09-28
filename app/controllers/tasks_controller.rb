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
  end

  def edit
  end

  def destroy
  end
end
