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

  before_create do
    set_default_title
    set_hash_id
  end

  after_create { tweet_bot } if Rails.env.production?

  validates :messages,
    length: { minimum: 1, message: "are blank." }

  def url
    Rails.application.routes.url_helpers.snippet_url(host: "iiirc.org", id: id)
  end

  def owner?(user)
    user.try(:id) == user_id
  end

  private
  def set_default_title
    self.title = Time.now.to_s if self.title.blank?
  end

  def set_hash_id
    self.hash_id = Digest::SHA512.hexdigest(Settings.snippet.salt + Time.now.to_i.to_s)[0..19] unless self.published?
  end

  def tweet_bot
    return unless published?
    begin
      Twitter.update("%s" % %w(あっ アッ わっ ワッ !!).sample)
    rescue Twitter::Error::Forbidden => e
      logger.warn "Twitter.update was failed: %s" % e.message
    end
    Twitter.update("%s ( %s - %s )" % [messages.try(:first).try(:content), title, url])
  end
end
