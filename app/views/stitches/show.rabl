object @stitch
  attributes :name, :description, :rejected

  child :user do
    attributes :id, :name, :username
  end

  #child @images do
  #  attributes :id, :url
  #end

  #child @video do
  #  attribute :created_at
  #  attribute :panda_video_id => :id
  #end

  child @original_video => :video do
    extends "videos/show"
  end
