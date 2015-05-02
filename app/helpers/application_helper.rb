module ApplicationHelper

  EMPTY_STRING = ''.freeze

  def render_list(opts = {})
    list = []
    yield(list)
    items = []
    list.each do |link|
      item_class = EMPTY_STRING
      url = link.match(/href=(["'])(.*?)(\1)/)[2] rescue nil
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = "active"
      end
      items << content_tag("li", raw(link), class: item_class)

    end
    content_tag("ul", raw(items.join(EMPTY_STRING)), opts)
  end
end
