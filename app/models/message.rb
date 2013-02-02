class Message < ActiveRecord::Base
  belongs_to :snippet

  attr_accessible :content, :nick, :raw_content
end
