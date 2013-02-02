class Message < ActiveRecord::Base
  attr_accessible :content, :nick, :raw_content
end
