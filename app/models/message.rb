class Message < ActiveRecord::Base
  PATTERN = Regexp.union([
    /^(?<time>\d\d\:\d\d)\s+(?<nick>([^\s\:]+)\:|(?<nick>\([^\s\)]+\))) (?<content>.*)$/,
    /^(?<time>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\t(?<nick>([^\s]+))\t(?<content>.*)$/, # Weechat1
    /^(?<time>\d{2}:\d{2}:\d{2})\s*(?<nick>([^\s]+))\s*\|\s*(?<content>.*)$/, # Weechat2
    /^\[?(?<time>\d{2}:\d{2}:\d{2})\]? (?<nick>[^:]+):\t? (?<content>(.*))$/, # Textual
    /^(?<time>\d{2}:\d{2}) (?<nick>\w+) (?<content>.+)$/
  ])

  belongs_to :snippet
  has_many :stars, dependent: :destroy

  validates :raw_content, presence: true

  before_create :parse_content

  def star_count
    stars.reduce(0) {|sum, star| sum + star.count}
  end

  def parse_content
    return if self.raw_content.blank?
    matched = PATTERN.match(self.raw_content)
    if matched
      self.content ||= matched[:content]
      self.nick    ||= matched[:nick].delete(':()')
      self.time    ||= matched[:time]
      self
    end
  end
end
