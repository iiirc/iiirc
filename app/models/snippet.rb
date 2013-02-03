class Snippet < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :messages, dependent: :destroy

  attr_accessible :published, :title, :organization_id

  attr_writer :content

  scope :published,   where(published: true)
  scope :unpublished, where(published: false)
end
