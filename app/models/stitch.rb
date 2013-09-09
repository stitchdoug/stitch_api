class Stitch < ActiveRecord::Base
  attr_accessible :description, :file_url, :name, :notes, :rejected
  belongs_to :user

  validates :description, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: "stitches.created_at DESC"
end
