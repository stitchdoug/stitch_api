class StitchesController < ApplicationController
  before_filter :signed_in_user, only: [:show, :create, :destroy]
  #before_filter :api_auth, only: [:create, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    #@stitches = Stitch.paginate(page: params[:page])
    redirect_to root_path
  end

  def show
    @stitch = Stitch.find(params[:id])

    # Find all associated images, if any
    if @stitch.images.any?
      @images = @stitch.images.all
    end

    # Set up for image attachment
    if is_admin? || current_user?(@stitch.user)
      @image = @stitch.images.build
    end

    # Set up for video upload
    if @stitch.video
      @video = @stitch.video
      @original_video = @video.panda_video
      @h264_encoding = @original_video.encodings["h264"]
    else
      if is_admin? || current_user?(@stitch.user)
        @video = Video.new
      end
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