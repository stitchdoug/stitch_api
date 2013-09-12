module StitchesHelper

  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  def count_unfinished
    Stitch.where("file_url is NULL and rejected is NULL").count
  end

  def get_name(name)
    # `name` will be nil in the database if one isn't given
    name != "" ? name : "Untitled"
  end

  def get_status(rejected = nil, file_url = nil)
    # Generate a <span> showing a status label
    if rejected == true
      content_tag(:span, "Rejected", :class => "label label-important")
    elsif rejected != true && file_url != nil
             content_tag(:span, "Complete", :class => "label label-success")
    elsif rejected == nil && file_url == nil
        content_tag(:span, "Pending", :class => "label")
    end
  end

  private

  def wrap_long_string(text, max_width = 30)
    zero_width_space = "&#8203;"
    regex = /.{1,#{max_width}}/
    (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
  end
end
