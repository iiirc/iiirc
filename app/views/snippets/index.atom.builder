atom_feed do |feed|
  feed.title    'iiirc'
  feed.subtitle 'Recent snippets'
  feed.updated  @snippets.first.try(:updated_at)
  feed.author do |person|
    person.name 'iiirc developers'
    person.uri  'http://iiirc.org'
  end
  feed.icon 'https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6'
  Settings.pubsubhubbub.each do |hub|
    feed.link rel: 'hub', href: hub.hub
  end
  @snippets.each do |snippet|
    cache snippet.cache_key format: :atom do
      render 'snippets/snippet', builder: feed, snippet: snippet
    end
  end
end
