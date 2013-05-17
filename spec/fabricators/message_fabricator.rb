Fabricator(:message) do
  time_value = Time.now.strftime('%H%M')
  nick_value = 'iiirc'
  content_value = 'content'
  snippet     { Fabricate(:snippet) }
  content     { content_value }
  nick        { nick_value }
  time        { time_value }
  raw_content { "#{time_value} #{nick_value}: #{content_value}" }
end
