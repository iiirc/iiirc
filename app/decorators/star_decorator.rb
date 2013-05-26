class StarDecorator < Draper::Decorator
  delegate_all

  def image_tag
    h.link_to h.image_tag(user.gravatar_url, alt: user.username, title: user.username, :'data-user-id' => user_id, class: 'starred-by-icon'), h.user_url(user.username)
  end
end
