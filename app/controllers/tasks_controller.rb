class TasksController < ApplicationController

  before_action :check_login
  before_action :check_correct_user, only: [:edit, :update, :destroy, :show]

  def index
    @tasks = @user.tasks.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.create(title: params[:post][:title], description: params[:post][:description])
    @user.tasks << task
    redirect_to action: "index"
  end

  # StackOverflow post on how to identify the referer (sending page) of a request:
  # http://stackoverflow.com/questions/16818542/how-can-i-check-which-page-has-sent-the-form.
  # If the request to update does not come from edit, it must be a completion button click
  # occurring on either index or a show page.

  def update

    if request.referer.present? && request.referer.include?('edit')
      @task.update(title: params[:patch][:title], description: params[:patch][:description])
      redirect_to action: "show", id: params[:id]
    else
      @task.update(completed_at: DateTime.now)

      if request.referer.present? && request.referer.include?('show')
        redirect_to action: "show", id: params[:id]
      else
        redirect_to action: "index"
      end
    end

  end

  def edit
  end

  def destroy
    @task.destroy
    redirect_to action: "index"
  end

  private

  def check_login
    if !session[:user]
      flash[:notice] = "Please log in first!"
      redirect_to sessions_index_path
    else
      @user = User.find_by(id: session[:user])
    end
  end

  def check_correct_user
    @task = Task.find_by(id: params[:id])
    if !@task || !@user.tasks.include?(@task)
      flash[:notice] = "Sorry, that is not one of your tasks."
      redirect_to index_path
    end
  end

end
