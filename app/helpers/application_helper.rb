module ApplicationHelper
  def full_title(page_title)
    base_title = 'Rubyboost'

    if page_title.empty?
      base_title
    else
      "#{base_title} #{page_title}"
    end
  end

  def newsfeed_template_kind_path(kind)
    NewsfeedAndMailService.template_path_for_kind(kind)
  end
end
