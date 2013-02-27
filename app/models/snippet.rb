class Snippet < ActiveRecord::Base
  SALT = "X+w3KGECgYEA4OOyrIrQ66sf+1ZV14hCFSHdgPjyIcwI/3HzOlPhsCAkkyI4oBm/"

  belongs_to :user
  belongs_to :organization
  has_many :messages, dependent: :destroy

  attr_accessible :published, :title, :organization_id

  attr_writer :content

  scope :date_desc,   order("created_at desc")
  scope :date_asc,    order("created_at asc")
  scope :published,   where(published: true)
  scope :unpublished, where(published: false)
end
