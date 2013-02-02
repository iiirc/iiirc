class Message < ActiveRecord::Base
  belongs_to :snippet

  attr_accessible :content, :nick, :raw_content

  validates :raw_content, presence: true

  def to_s
    raw_content
  end
end
