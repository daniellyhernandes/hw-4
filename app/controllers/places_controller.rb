class PlacesController < ApplicationController

  def index
    #If user is logged in, allow to create the post + send the place_id to the front
    # if @current_user
      @places = Place.all
    # else
    #   redirect_to "/login"  
    # end
  end

  def show
    if @current_user
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"]}).and(Post.where({ "user_id" => @current_user["id"]}))
  else
    flash["notice"] = "You must login to see posts"
    redirect_to "/login"  
  end

  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["place"]["name"]
    @place.save
    redirect_to "/places"
  end

end
