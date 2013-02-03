class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  attr_accessible :count, :message, :user
end
