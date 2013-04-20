builder.entry snippet do |entry|
  entry.title     snippet.title
  entry.author do |person|
    username = snippet.user.username
    person.name username
    person.uri  github_user_url(username)
  end
  entry.content   snippet.messages.map(&:raw_content).join($/), type: 'text'
end
