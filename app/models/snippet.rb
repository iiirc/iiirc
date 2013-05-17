# coding: utf-8
class Snippet < ActiveRecord::Base
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

  def owner?(user)
    user.try(:id) == user_id
  end

  private
  def tweet_bot
    return unless published?
    Twitter.update("%s" % %w(あっ アッ わっ ワッ !!).sample)
    Twitter.update("%s ( %s - %s )" % [messages.try(:first).try(:content), title, url])
  end
end
