class ImagesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  #before_filter :api_auth, only: [:create, :destroy]
  before_filter :correct_image, only: [:destroy]

  def create
    if current_user.admin?
      @image = Stitch.find(params[:stitch_id]).images.build(params[:image])
    else
      @image = current_user.stitches.find(params[:stitch_id]).images.build(params[:image])
    end

    if @image.save
      flash[:success] = "Image attached"
      redirect_to stitch_path(params[:stitch_id])
    else
      redirect_to stitch_path(params[:stitch_id])
    end
  end

  def destroy
    @image.destroy
    flash[:success] = "Image deleted"
    redirect_to stitch_path(params[:stitch_id])
  end

  private

  def correct_image
    # Admin should be able to update and delete all Images. Regular users should only be able
    # to affect their own

    if current_user.admin?
      @image = Image.find_by_id(params[:id])
    else
      @image = current_user.stitches.find_by_id(params[:stitch_id]).images.find_by_id(params[:id])
    end
    redirect_to root_url if @image.nil?
  end
end
