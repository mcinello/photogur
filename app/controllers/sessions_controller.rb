class SessionsController < ApplicationController
  def new

  end

  def create
    # user not instantiated because we are only logging in, not creating new user
    # find user by email typed in the email input field and assign it to variable 'user'
    user = User.find_by(email: params[:email])

    #  check to see if user exists and can be authenticated with the password
    # if both evaluate to true, a key-value pair is created in session hash
    # :user_id is the key and user's id is value
    #session key is assigned user directed to pictures index page
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to pictures_url, notice: "Logged in!"
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to pictures_url, notice: "Logged out!"
  end
end
