builder.entry snippet do |entry|
  entry.title     snippet.title
  entry.author do |person|
    user = snippet.user
    person.name user.username
    person.uri  user.github_url
  end
  entry.content type: 'xhtml' do |content|
    content.ul do |ul|
      snippet.messages.each do |message|
        ul.li message.raw_content
      end
    end
  end
end
