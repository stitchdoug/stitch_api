object @original_video => :video

  node do |video|
  # The hash returned from this unnamed node will be merged into the parent, so we
  # just return the hash we want to be represented in the root of the response.
  # RABL will render anything inside this hash as JSON (nested hashes, arrays, etc)
  # Note: we could also return a new hash of specific keys and values if we didn't
  # want the whole hash
  {
    id:         video.id,
    status:     video.status,
    created_at: video.created_at,
    url:        video.url,
    mime_type:  video.mime_type,
    duration:   video.duration,
    height:     video.height,
    width:      video.width
  }
  end

  child @original_video.encodings["h264"] => :h264 do
    node do |encoding|
    {
        id:         encoding.id,
        status:     encoding.status,
        created_at: encoding.created_at,
        url:        encoding.url,
        screenshot: encoding.screenshots[3],
        mime_type:  encoding.mime_type,
        duration:   encoding.duration,
        height:     encoding.height,
        width:      encoding.width
    }
    end
  end

  child @original_video.encodings["h264.hi"] => :h264_hi do
    node do |encoding|
      {
          id:         encoding.id,
          status:     encoding.status,
          created_at: encoding.created_at,
          url:        encoding.url,
          screenshot: encoding.screenshots[3],
          mime_type:  encoding.mime_type,
          duration:   encoding.duration,
          height:     encoding.height,
          width:      encoding.width
      }
    end
  end

  child @original_video.encodings["ogg"] => :ogg do
    node do |encoding|
      {
          id:         encoding.id,
          status:     encoding.status,
          created_at: encoding.created_at,
          url:        encoding.url,
          screenshot: encoding.screenshots[3],
          mime_type:  encoding.mime_type,
          duration:   encoding.duration,
          height:     encoding.height,
          width:      encoding.width
      }
    end
  end

  child @original_video.encodings["ogg.hi"] => :ogg_hi do
    node do |encoding|
      {
          id:         encoding.id,
          status:     encoding.status,
          created_at: encoding.created_at,
          url:        encoding.url,
          screenshot: encoding.screenshots[3],
          mime_type:  encoding.mime_type,
          duration:   encoding.duration,
          height:     encoding.height,
          width:      encoding.width
      }
    end
  end

  child @original_video.encodings["webm"] => :webm do
    node do |encoding|
      {
          id:         encoding.id,
          status:     encoding.status,
          created_at: encoding.created_at,
          url:        encoding.url,
          screenshot: encoding.screenshots[3],
          mime_type:  encoding.mime_type,
          duration:   encoding.duration,
          height:     encoding.height,
          width:      encoding.width
      }
    end
  end

  child @original_video.encodings["webm.hi"] => :webm_hi do
    node do |encoding|
      {
          id:         encoding.id,
          status:     encoding.status,
          created_at: encoding.created_at,
          url:        encoding.url,
          screenshot: encoding.screenshots[3],
          mime_type:  encoding.mime_type,
          duration:   encoding.duration,
          height:     encoding.height,
          width:      encoding.width
      }
    end
  end
