class Organization < ActiveRecord::Base
  has_many :user_organizations
  has_many :users, through: :user_organizations

  def to_param
    login
  end
end
