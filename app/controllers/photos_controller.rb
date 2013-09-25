class PhotosController < ApplicationController
  load_and_authorize_resource

  def index
    @photos = Photo.all.page(params[:page]).per(32)
  end

  def show
    @photo = Photo.show
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.remote_url = (photo_params[:remote_file_url] || nil)
    @photo.user_id = current_user.id
    @photo.save ? redirect_to(photos_path) : render(action: :new)
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params) ? redirect_to(photos_path) : render(action: :edit)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to(photos_path)
  end

  private
  def photo_params
    params.require(:photo).permit(:name, :file, :remote_file_url)
  end
end
