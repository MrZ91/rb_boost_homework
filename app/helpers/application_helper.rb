module ApplicationHelper
  def full_title(page_title)
    base_title = 'Rubyboost'

    if page_title.empty?
      base_title
    else
      "#{base_title} #{page_title}"
    end
  end
end

def random_from(n, from)
  array_of_id = []
  while array_of_id.count < n
    rnd = rand(from)
    array_of_id << rnd unless array_of_id.include?(rnd)
  end
  array_of_id
end
