class PostsController < ApplicationController

  def new
    #If user is logged in, allow to create the post + send the place_id to the front
    if @current_user
      @post = Post.new
      @post.place_id = params["place_id"]
    #If user is not logged in, message + redirect to login
    else
      flash["notice"] = "You must login to post"
      redirect_to "/login"  
    end
  end

  def create
    #If user is logged in, create the post
    if @current_user
      @post = Post.new
      @post["title"] = params["post"]["title"]
      @post["description"] = params["post"]["description"]
      @post["posted_on"] = params["post"]["posted_on"]
      @post["place_id"] = params["post"]["place_id"]
      @post["user_id"] = @current_user["id"]
      @post.save
      redirect_to "/places/#{@post["place_id"]}"
    else
      flash["notice"] = "You must login to post"
      redirect_to "/login"
    end
  end

end
