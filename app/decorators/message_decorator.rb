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

  def content
    Rinku.auto_link(h.html_escape(model.content), :all) {|link|
      link =~ IMAGE_RE ? %(#{link}<br><img src="#{link}" alt="">) : link
    }
  end
end
