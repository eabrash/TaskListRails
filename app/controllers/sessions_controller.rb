class SessionsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user])
  end

  def create
    auth_hash = request.env['omniauth.auth']

    if !auth_hash['uid']
      redirect_to login_failure_path
    end

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')

    # if there is no user matching
    if @user.nil?
     @user = User.build_from_github(auth_hash)
     if !@user.save
       flash[:notice] = "Sorry, there was a problem pulling data from your Github account. User not created."
     end
    end

    session[:user] = @user.id

    redirect_to index_path
  end

  def destroy
    session[:user] = nil
    redirect_to sessions_index_path
  end
end
