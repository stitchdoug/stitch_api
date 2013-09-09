class StitchesController < ApplicationController
  #before_filter :signed_in_user, only: [:create, :destroy]
  #before_filter :api_auth, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def index
    @stitches = Stitch.paginate(page: params[:page])
  end

  def show
    @stitch = Stitch.find(params[:id])
  end

  def new
    redirect_to(root_path) if signed_in?
    @stitch = Stitch.new
  end

  def create
    @stitch = current_user.stitches.build(params[:stitch])
    if @stitch.save
      flash[:success] = "Stitch created!"
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
    redirect_to root_url
  end

  private

  def correct_user
    @stitch = current_user.stitches.find_by_id(params[:id])
    redirect_to root_url if @stitch.nil?
  end

  def api_auth
    unless params[:api_key] == current_user.api_key
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end