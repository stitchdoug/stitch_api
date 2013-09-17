class Image < ActiveRecord::Base
  attr_accessible :url
  belongs_to :stitch

  validates :stitch_id, presence: true
  validates :url, presence: true
end
