# Needed to use count_unfinished method in view
include StitchesHelper

class StaticPagesController < ApplicationController
  def home
    if signed_in? && current_user.admin?
      @stitch = current_user.stitches.build
#      @feed_items = current_user.feed.paginate(page: params[:page])
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
