class Video < ActiveRecord::Base
  attr_accessible :panda_video_id, :title
  belongs_to :stitch

  validates_presence_of :panda_video_id

  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end
end
