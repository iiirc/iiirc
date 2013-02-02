class Snippet < ActiveRecord::Base
  belongs_to :user

  attr_accessible :content, :published, :title
end
