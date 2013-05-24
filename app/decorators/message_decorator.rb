class MessageDecorator < Draper::Decorator
  IMAGE_RE = %r!
    \.(jpe?g|gif|png|bmp|tiff?)\Z
    |
    \Ahttps:\/\/secure.gravatar.com\/avatar\/
  !ix

  delegate_all
  decorates_association :stars

  def content
    links = []
    escaped = h.html_escape(model.content)
    marked =
      if snippet.published?
        Rinku.auto_link(escaped, :all) {|link|
          links << link if link =~ IMAGE_RE
          link
        }
      else
        escaped.gsub(URI.regexp(%w[http https ftp mailto])) {|link|
          links << link if link =~ IMAGE_RE
          h.link_to(link, h.transition_path(to: link))
        }
      end
    if links.present?
      marked << '<br>'
      links.each do |link|
        uri = snippet.published? ? link : h.transition_path(to: link)
        src = snippet.published? ? link : h.image_proxy_path(of: link)
        marked << h.link_to(h.image_tag(src, alt: ''), uri)
      end
    end
    marked
  end

  def star_count_tag
    h.content_tag(:span, star_count, class: 'count')
  end

  def starred_by_tag
    starred_by = stars.map(&:image_tag).join
    h.content_tag(:span, h.raw(starred_by), class: 'starred-by')
  end
end
