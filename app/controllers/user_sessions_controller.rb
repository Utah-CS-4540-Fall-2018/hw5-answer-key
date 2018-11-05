class UserSessionsController < ApplicationController
  skip_before_action :must_be_logged_in, only: [:new, :create]

  # GET /user_sessions/new
  def new
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    # to create a user session, we need to verify that the user
    # should be allowed into the system.  for this version, we're just
    # going to check that the user's email is in our user table.
    user = User.find_by(email: user_session_params[:email])
    if user
      session[:user] = user.id
      redirect_to root_path
    else
      if user_session_params[:email]
        flash.notice = 'We were unable to find that email address in our records.'
      else
        flash.notice = "Please enter an email address to login."
      end
      render :new
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    session[:user] = nil
    redirect_to external_root_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_session_params
      params.permit(:email)
    end
end
