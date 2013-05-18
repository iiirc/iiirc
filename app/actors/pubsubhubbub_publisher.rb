class PubsubhubbubPublisher
  include Celluloid
  include Celluloid::Logger

  class << self
    def start(faraday_adapter=nil)
      hubs.each do |uri|
        supervise_as uri, faraday_adapter
      end
    end

    def perform
      actors.each &:perform
    end

    def stubs
      @stub ||= Faraday::Adapter::Test::Stubs.new {|stub| stub.post [204, {}, '']}
    end

    # private :new

    private

    def hubs
      Settings.pubsubhubbub.hubs.collect(&:pub)
    end

    def actors
      hubs.map {|uri| Celluloid::Actor[uri]}
    end
  end

  def initialize(uri, faraday_adapter=nil)
    @client = Faraday.new(uri) {|faraday|
      faraday.request :url_encoded
      if faraday_adapter == :test
        faraday.adapter faraday, self.class.stubs
      else
        faraday.adapter (faraday_adapter || Faraday.default_adapter)
      end
    }
  end

  def perform
    @client.post 'hub.mode' => publish, 'hub.url' => Rails.application.routes.url_helpers.url_for(controller: 'snippets', action: 'index', format: :atom)
  end
end
