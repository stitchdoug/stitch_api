# Needed to use count_unfinished method in view
include StitchesHelper

class StaticPagesController < ApplicationController
  def home
    if signed_in? && current_user.admin?
      @stitch = current_user.stitches.build

      # Optionally include up to 8 images with one request
      @images = Array.new(8)

      # Feed, for admins should just be a paginated list of all Stitches
      #@feed_items = current_user.feed.paginate(page: params[:page])
      @feed_items = Stitch.paginate(page: params[:page], per_page: 20)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
