class Snippet < ActiveRecord::Base
  SALT = "X+w3KGECgYEA4OOyrIrQ66sf+1ZV14hCFSHdgPjyIcwI/3HzOlPhsCAkkyI4oBm/"

  belongs_to :user
  belongs_to :organization
  has_many   :messages, dependent: :destroy

  attr_accessible :published, :title, :organization_id

  attr_writer :content

  scope :date_desc,   order("created_at desc")
  scope :date_asc,    order("created_at asc")
  scope :published,   where(published: true)
  scope :unpublished, where(published: false)

  after_create { tweet_bot } if Rails.env.production?

  def url
    Rails.application.routes.url_helpers.snippet_url(host: "iiirc.org", id: id)
  end

  private
  def tweet_bot
    Twitter.update("new iiirc - %s - %s" % [title, url]) if published?
  end
end
