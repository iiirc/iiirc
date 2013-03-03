class Message < ActiveRecord::Base
  belongs_to :snippet
  has_many :stars, dependent: :destroy

  attr_accessible :content, :nick, :time, :raw_content

  validates :raw_content, presence: true

  before_create :parse_content

  def parse_content
    return if self.raw_content.blank?
    matched = /^(?<time>\d\d\:\d\d)\s+(?<nick>([^\s\:]+)\:|(?<nick>\([^\s\)]+\))) (?<content>.*)$/.match(self.raw_content) # todo: use setting
    if matched
      self.content ||= matched[:content]
      self.nick    ||= matched[:nick].delete(':()')
      self.time    ||= matched[:time]
      self
    end
  end
end
