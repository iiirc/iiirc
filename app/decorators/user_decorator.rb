class UserDecorator < Draper::Decorator
  GITHUB_URL_STEM = 'https://github.com'
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def github_url
    "#{GITHUB_URL_STEM}/#{ERB::Util.url_encode(username)}"
  end
end