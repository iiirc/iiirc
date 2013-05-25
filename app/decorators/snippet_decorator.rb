class SnippetDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :messages

  def cache_key(options={format: :html})
    "snippet_#{model.id}.#{options[:format]}"
  end
end
