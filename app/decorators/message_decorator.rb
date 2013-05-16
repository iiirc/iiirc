class MessageDecorator < Draper::Decorator
  IMAGE_RE = %r!
    \.(jpe?g|gif|png|bmp|tiff?)\Z
    |
    \Ahttps://secure.gravatar.com/avatar/
  !ix

  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  # @todo: link to images when secret
  def content
    if snippet.published?
      Rinku.auto_link(h.html_escape(model.content), :all) {|link|
        link =~ IMAGE_RE ? %(#{link}<br><img src="#{link}" alt="">) : link
      }
    else
      model.content.gsub URI.regexp(%w[http https ftp mailto]) do |uri|
        h.link_to uri, h.transition_path(uri: h.url_encode(uri).gsub('.', '%2E'))
      end
    end
  end
end
