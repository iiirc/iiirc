RSpec::Matchers.define :be_valid_atom do |expected|
  match do |actual|
    feed = RSS::Parser.parse(actual)
    feed.feed_type == 'atom'
  end
end
