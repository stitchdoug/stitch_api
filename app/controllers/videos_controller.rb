class VideosController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  #before_filter :api_auth, only: [:create, :destroy]
  before_filter :correct_video, only: [:destroy]

  #def show
  #  @video = Video.find(params[:id])
  #  @original_video = @video.panda_video
  #  @h264_encoding = @original_video.encodings["h264"]
  #end

  #def new
  #  @video = Video.new
  #end

  def create
    @stitch = Stitch.find(params[:stitch_id])
    @video = @stitch.build_video(params[:video])

    if @video.save
      flash[:success] = "Video uploaded"
      redirect_to stitch_path(params[:stitch_id])
    else
      redirect_to stitch_path(params[:stitch_id])
    end

    #@video = Video.create!(params[:video])
    #redirect_to :action => :show, :id => @video.id
  end

  def destroy
    if @video.panda_video.delete
      @video.destroy
      flash[:success] = "Video deleted"
      redirect_to stitch_path(params[:stitch_id])
    end
  end

  private

  def correct_video
    # Admin should be able to update and delete all videos. Regular users should only be able
    # to affect their own

    if current_user.admin?
      @video = Video.find(params[:id])
    else
      @video = current_user.stitches.find(params[:stitch_id]).video
    end
    redirect_to root_url if @video.nil?
  end
end