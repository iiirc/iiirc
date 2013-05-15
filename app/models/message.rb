class Message < ActiveRecord::Base
  REGEXP = /
    ^(?<time>\d\d\:\d\d)\s+(?<nick>([^\s\:]+)\:|(?<nick>\([^\s\)]+\)))\ (?<content>.*)$
    |
    ^(?<time>\d{4}-\d{2}-\d{2}\ \d{2}:\d{2}:\d{2})\t(?<nick>([^\s]+))\t(?<content>.*)$ # Weechat
    |
    ^\[(?<time>\d{2}:\d{2}:\d{2})\]\ (?<nick>[^:]+):\ (?<content>(.*))$ # Textual
  /xo

  belongs_to :snippet
  has_many :stars, dependent: :destroy

  attr_accessible :content, :nick, :time, :raw_content

  validates :raw_content, presence: true

  before_create :parse_content

  def parse_content
    return if self.raw_content.blank?
    matched = REGEXP.match(self.raw_content)
    if matched
      self.content ||= matched[:content]
      self.nick    ||= matched[:nick].delete(':()')
      self.time    ||= matched[:time]
      self
    end
  end
end
