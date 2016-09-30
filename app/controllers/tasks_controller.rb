class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  #StackOverflow post on how to identify the referer (sending page) of a request

  def update

    task = Task.find(params[:id])

    if params[:patch]
      task.update(title: params[:patch][:title], description: params[:patch][:description])
      redirect_to action: "show", id: params[:id]
    else
      task.update(completed_at: DateTime.now)

      if request.referer.present? && request.referer.include?('show')
        redirect_to action: "show", id: params[:id]
      else
        redirect_to action: "index"
      end
    end

  end

  def show
    @task = Task.find(params[:id].to_i)
  end

  def create
    Task.create(title: params[:post][:title], description: params[:post][:description])
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
