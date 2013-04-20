atom_feed do |feed|
  feed.title    'iiirc'
  feed.subtitle 'Recent snippets'
  feed.updated  @snippets.first.try(:updated_at)
  feed.author do |person|
    person.name 'iiirc developers'
    person.uri  'http://iiirc.org'
  end
  @snippets.each do |snippet|
    render 'snippets/snippet', builder: feed, snippet: snippet
  end
end
