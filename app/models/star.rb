class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  validates :message_id, presence: true
  validates :user_id, presence: true
end
