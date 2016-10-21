class TasksController < ApplicationController

  before_action :check_login

  def index
    @tasks = Task.all
    @user = User.find_by(id: session[:user])
  end

  def new
    @task = Task.new
  end

  # StackOverflow post on how to identify the referer (sending page) of a request:
  # http://stackoverflow.com/questions/16818542/how-can-i-check-which-page-has-sent-the-form.
  # If the request to update does not come from edit, it must be a completion button click
  # occurring on either index or a show page.

  def update

    task = Task.find(params[:id])

    if request.referer.present? && request.referer.include?('edit')
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

  private

  def check_login
    if !session[:user]
      redirect_to sessions_index_path
    end
  end

end
