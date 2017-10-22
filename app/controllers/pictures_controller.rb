class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]

  def index
    @most_recent_pictures = Picture.most_recent_five
    @pictures = Picture.all
    @older_pictures = Picture.created_before(1.month.ago)
    @pictures_in_same_year = Picture.pictures_created_in_year(2017)
  end

  def show
    @picture = Picture.find(params[:id])
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
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

    @picture.title = params[:picture][:title]
  @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to '/pictures/#{@picture.id}'
    else
      render :edit
    end
  end

def destroy
  @picture = Picture.find(params[:id])
  @picture.destroy
  redirect_to "/pictures"
end

end
