Settings.pubsubhubbub.each do |hub|
  PubsubhubbubNotifier.instances << PubsubhubbubNotifier.new(hub.pub)
end
