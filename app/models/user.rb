class User < ActiveRecord::Base
  attr_accessible :organization_ids

  include Gravtastic
  gravtastic secure: true, size: 24

  has_many :snippets, dependent: :destroy
  has_many :user_organizations, dependent: :destroy
  has_many :organizations, through: :user_organizations
  accepts_nested_attributes_for :user_organizations

  def self.new_with_omniauth(auth)
    new do |user|
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.username = auth['info']['nickname']
      user.email    = auth['info']['email']
      user.token    = auth['credentials']['token']
    end
  end

  def self.create_with_omniauth(auth)
    new_with_omniauth(auth).save!
  end
end
