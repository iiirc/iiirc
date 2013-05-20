class MessageDecorator < Draper::Decorator
  IMAGE_RE = %r!
    \.(jpe?g|gif|png|bmp|tiff?)\Z
    |
    \Ahttps://secure.gravatar.com/avatar/
  !ix

  delegate_all
  decorates_association :stars

  # @todo: link to images when secret
  def content
    if snippet.published?
      Rinku.auto_link(h.html_escape(model.content), :all) {|link|
        link =~ IMAGE_RE ? %(#{link}<br><img src="#{link}" alt="">) : link
      }
    else
      model.content.gsub URI.regexp(%w[http https ftp mailto]) do |uri|
        h.link_to uri, h.transition_path(to: uri)
      end
    end
  end

  def star_count_tag
    h.content_tag(:span, star_count, class: 'count')
  end

  def starred_by_tag
    starred_by = stars.map(&:image_tag).join
    h.content_tag(:span, h.raw(starred_by), class: 'starred-by')
  end
end
