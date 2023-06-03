class SessionsController < ApplicationController
  def new
  end

  def create
    #Find the user
    @user = User.find_by({"email" => params["email"]})
    #Verify if user exists
    if @user
    #Verify if encripted password matches
      if BCrypt::Password.new(@user["password"]) == params["password"]  
    #Case true, define session_user_id + message + redirect to "places"
        session["user_id"] = @user["id"] 
        flash["notice"] = "Welcome to the travel journal, #{@user["username"]}!"
        redirect_to "/places"
    #Case false, message + redirect to login
      else
        flash["notice"] = "Your password is wrong"
        redirect_to "/login"  
      end
    else
      flash["notice"] = "User not found"
      redirect_to "/login"  
    end

  end


  # When user press Logout, delete all the information stored in the browser and redirect to "/login"
  def destroy
    session["user_id"] = nil
    flash["notice"] = "Bye bye!"
    redirect_to "/login"
  end
end
  