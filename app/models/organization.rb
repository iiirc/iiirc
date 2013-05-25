class Organization < ActiveRecord::Base
  has_many :user_organizations
  has_many :users, through: :user_organizations
  has_many :snippets

  scope :has_snippets, -> { joins(:snippets) }

  def to_param
    login
  end
end
