atom_feed do |feed|
  feed.title    'iiirc'
  feed.subtitle "#{@user.username}'s recent snippets"
  feed.updated  @snippets.first.try(:updated_at)
  feed.author do |person|
    person.name @user.username
    person.uri  url_for(@user)
  end
  feed.icon @user.gravatar_url
  @snippets.each do |snippet|
    render 'snippets/snippet', builder: feed, snippet: snippet
  end
end
