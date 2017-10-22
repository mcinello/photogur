class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def index
    @most_recent_pictures = Picture.most_recent_five
    @pictures = Picture.all
    @older_pictures = Picture.created_before(1.month.ago)
    @pictures_in_same_year = Picture.pictures_created_in_year(2017)
  end

  def show
    load_picture
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id

    if @picture.save
      #if picture gets saved, generate a get request
      redirect_to "/pictures"
    else
      #otherwise render new.html.erb
      render :new
    end
  end

  def edit
    load_picture
    ensure_user_owns_picture
  end

  def update
    load_picture
    ensure_user_owns_picture

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to picture_path
    else
      render :edit
    end
  end

  def destroy
    load_picture
    ensure_user_owns_picture

    @picture.destroy
    redirect_to "/pictures"
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    unless current_user == @picture.user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end

end
