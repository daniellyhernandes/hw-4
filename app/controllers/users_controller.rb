class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #check if the user exists
    @user = User.find_by({"email" => params["user"]["email"]})
    # case true, send a message and redirect to login page
    if @user 
      flash["notice"] = "This email already exists"
      redirect_to "/login"
    # case false, create a signup for the user
    else
      @user = User.new
      @user["username"] = params["user"]["username"]
      @user["email"] = params["user"]["email"]
      @user["password"] = BCrypt::Password.create(params["user"]["password"])
      @user.save
      session["user_id"] = @user["id"]
      redirect_to "/places"
    end
  end
end
