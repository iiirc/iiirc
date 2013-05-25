# coding: utf-8
class Snippet < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many   :messages, dependent: :destroy

  attr_writer :content

  scope :date_desc,   -> { order("created_at desc") }
  scope :date_asc,    -> { order("created_at asc")  }
  scope :published,   -> { where(published: true)   }
  scope :unpublished, -> { where(published: false)  }
  scope :with_assoc,  -> { includes(messages: [:stars]) }

  before_create do
    set_default_title
    set_hash_id
  end

  after_create do
    TweetBot.tweet(self) if Rails.env.production? && published?
    PubsubhubbubNotifier.notify if published?
  end

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
    self.hash_id = Digest::SHA512.hexdigest(Settings.snippet.salt + Time.now.to_i.to_s)[0..19] unless published?
  end
end
