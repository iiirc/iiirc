builder.entry snippet do |entry|
  entry.title     snippet.title
  entry.author do |person|
    user = snippet.user
    person.name user.username
    person.uri  user.github_url
  end
  entry.content   snippet.messages.map(&:raw_content).join($/), type: 'text'
end
