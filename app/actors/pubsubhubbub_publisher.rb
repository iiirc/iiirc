class PubsubhubbubPublisher
  include Celluloid
  include Celluloid::Logger

  class << self
    def start(faraday_adapter=nil)
      hubs.each do |uri|
        supervise_as uri, uri, faraday_adapter
      end
    end

    def perform
      actors.each &:perform
    end

    def stubs
      @stub ||= Faraday::Adapter::Test::Stubs.new {|stub| stub.post('') {[204, {}, '']}}
    end

    private :new

    private

    def hubs
      Settings.pubsubhubbub.hubs.collect(&:pub)
    end

    def actors
      hubs.map {|uri| Celluloid::Actor[uri]}
    end
  end

  def initialize(uri, faraday_adapter=nil)
    info "Initialize PubSubHubbub Publisher for: #{uri}"
    @uri = URI(uri)
    @client = Faraday.new(url: uri) {|faraday|
      faraday.request :url_encoded
      faraday.response :logger
      if faraday_adapter == :test
        faraday.adapter faraday_adapter do |stub|
          stub.post(@uri.request_uri) {[204, {}, '']}
        end
      else
        faraday.adapter (faraday_adapter || Faraday.default_adapter)
      end
    }
  end

  def perform
    info "[#{self.class}]POST #{@uri}"
    @client.post @uri.request_uri,
                 'hub.mode' => 'publish',
                 'hub.url'  => Rails.application.routes.url_helpers.url_for(controller: :snippets, action: :index, format: :atom)
  end
end
