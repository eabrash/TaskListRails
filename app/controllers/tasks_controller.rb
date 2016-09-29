class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
  end

  def update

    task = Task.find(params[:id])

    print "params title #{params[:title]}"
    print "params description #{params[:description]}"

    if params[:title] && params[:description]
      task.update(title: params[:title], description: params[:description])
      redirect_to action: "show", id: params[:id]
    else
      task.update(completed_at: DateTime.now)
      redirect_to action: "index"
    end

  end

  def show
    @task = Task.find(params[:id].to_i)
  end

  def create
    Task.create(title: params[:title], description: params[:description])
    redirect_to action: "index"
  end

  def edit
    @task = Task.find(params[:id].to_i)
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to action: "index"
  end
end
