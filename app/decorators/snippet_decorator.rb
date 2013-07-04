class SnippetDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :messages

  def nick_offset
    Digest::MD5.hexdigest(messages.first.try(:raw_content).to_s).to_i(16)
  end

  def cache_key(options={format: :html})
    "snippet_#{model.id}.#{options[:format]}"
  end

  def cache_key_with_stars(options={format: :html, signed_in: false})
    cache_key <<
      '_stars_' <<
      latest_star.try(:updated_at).to_i.to_s <<
      (options[:signed_in] ? '_signed_in' : '_signed_out')
  end

  def twitter_card_description
    msgs = messages.take(3).map(&:raw_content)
    msgs.last << '...' if messages.length > 3
    msgs << "Posted by #{user.username}"
    msgs.join(' / ')
  end
end
