class SnippetDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :messages

  def cache_key(options={format: :html})
    "snippet_#{model.id}.#{options[:format]}"
  end

  def cache_key_with_stars(options={format: :html, signed_in: false})
    cache_key <<
      '_stars_' <<
      latest_star.try(:updated_at).to_i.to_s <<
      (options[:signed_in] ? '_signed_in' : '_signed_out')
  end
end
