class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username

  include Gravtastic
  gravtastic secure: true, size: 24

  has_many :snippets, dependent: :destroy
  has_many :user_organizations, dependent: :destroy
  has_many :organizations, through: :user_organizations
  has_many :stars, dependent: :destroy
  accepts_nested_attributes_for :user_organizations

  def find_or_create_organizations
    octokit_client = Octokit::Client.new(login: username, oauth_token: token)
    return octokit_client.organizations(username).map do |organization|
      Organization.find_or_create_by(login: organization.login, original_id: organization.id)
    end
  end

  def self.new_with_omniauth(auth)
    new do |user|
      user.provider = auth[:provider]
      user.uid      = auth[:uid]
      user.username = auth[:info][:nickname]
      user.email    = auth[:info][:email]
      user.token    = auth[:credentials][:token]
    end
  end

  def self.create_with_omniauth(auth)
    new_with_omniauth(auth).save!
  end
end
