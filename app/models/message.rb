class Message < ActiveRecord::Base
  belongs_to :snippet

  attr_accessible :content, :nick, :raw_content

  validates :raw_content, presence: true

  def initialize(*)
    super

    return if self.raw_content.blank?
    if self.content.blank? || self.nick.blank?
      matched = /^(?:\d\d\:\d\d)\s+(?<nick>[^\s\:]+)\: (?<content>.*)$/.match(self.raw_content) # todo: use setting
      if matched
        self.content ||= matched[:content]
        self.nick    ||= matched[:nick]
      end
    end
  end

  def to_s
    raw_content
  end
end
