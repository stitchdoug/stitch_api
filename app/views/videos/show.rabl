object @video

child @video.panda_video do

node :width do |v|
  # The hash returned from this unnamed node will be merged into the parent, so we
  # just return the hash we want to be represented in the root of the response.
  # RABL will render anything inside this hash as JSON (nested hashes, arrays, etc)
  # Note: we could also return a new hash of specific keys and values if we didn't
  # want the whole hash
  v.width
  end

end
