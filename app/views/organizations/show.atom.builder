atom_feed do |feed|
  feed.title    'iiirc'
  feed.subtitle "#{@organization.login}'s recent snippets"
  feed.updated  @snippets.first.try(:updated_at)
  feed.author do |person|
    person.name @organization.login
    person.uri  url_for(@organization)
  end
  @snippets.each do |snippet|
    render 'snippets/snippet', builder: feed, snippet: snippet
  end
end
