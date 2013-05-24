class PubsubhubbubNotifier
  @instances = []

  class << self
    attr_accessor :instances

    def notify
      begin
        instances.each &:notify
      rescue => e
        Rails.logger.warn "[#{self}.#{__method__}]ERROR: #{e}"
      end
    end
  end

  attr_reader :client

  def initialize(uri)
    @uri = URI(uri)
    stem = uri.gsub(Regexp.escape(@uri.request_uri + '\Z'), '')
    @client = Faraday.new(stem) {|client|
      client.request :url_encoded
      client.adapter Faraday.default_adapter
    }
  end

  def notify
    Rails.logger.info "[#{self.class}##{__method__}]POST #{@uri}"
    return unless Rails.env.production? or Rails.env.test?
    response = @client.post @uri.request_uri, 'hub.mode' => 'publish',
      'hub.url' =>  Rails.application.routes.url_helpers.url_for(controller: :snippets, format: :atom)
    Rails.logger.warn("[#{self.class}##{__method__}]ERROR: status: %s, body: %s" % [response.status, response.body]) unless response.status == 204
    response
  end
end
