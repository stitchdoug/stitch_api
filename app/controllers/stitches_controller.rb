class StitchesController < ApplicationController
  before_filter :signed_in_user, only: [:show, :create, :destroy]
  #before_filter :api_auth, only: [:create, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @stitches = Stitch.paginate(page: params[:page])
  end

  def show
    @stitch = Stitch.find(params[:id])

    # Find all associated images, if any
    if Stitch.find(params[:id]).images.any?
      @images = Stitch.find(params[:id]).images.all
    end

    # Set up for image creation
    if signed_in? && current_user.admin?

      # Admin can attach images to any Stitch
      @image = Stitch.find(params[:id]).images.build
    elsif current_user?(Stitch.find(params[:id]).user)

      # Not admin, but this Stitch belongs to the logged in user
      @image = current_user.stitches.find(params[:id]).images.build
    end
  end

  def new
    redirect_to(root_path) if signed_in?
    @stitch = Stitch.new
  end

  def create
    @stitch = current_user.stitches.build(params[:stitch])
    if @stitch.save
      flash[:success] = "Stitch created!"

      # Check for attached image links
      @images = params[:image]
      @images.each do |image|
        if image != ''
          image = @stitch.images.build(url: image[:url])
          image.save
        end
      end

      # Send to home (where the feed should be, for Admins)
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
  end

  def update
    if @stitch.update_attributes(params[:stitch])
      flash[:success] = "Stitch updated"
      redirect_to @stitch
    else
      render 'edit'
    end
  end

  def destroy
    @stitch.destroy
    flash[:success] = "Stitch updated"
    redirect_to root_url
  end

  private

  def correct_user
    # Admin should be able to update and delete all Stitches. Regular users should only be able
    # to affect their own

    if current_user.admin?
      @stitch = Stitch.find_by_id(params[:id])
    else
      @stitch = current_user.stitches.find_by_id(params[:id])
    end
    redirect_to root_url if @stitch.nil?
  end

  def api_auth
    unless params[:api_key] == current_user.api_key
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end