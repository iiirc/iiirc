class UserOrganization < ActiveRecord::Base
  attr_accessible :user_id, :organization_id
  belongs_to :user
  belongs_to :organization
end
