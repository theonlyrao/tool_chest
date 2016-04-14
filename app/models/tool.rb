class Tool < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validate :tool_assigned_to_non_admin_user

  belongs_to :user
  belongs_to :category

  def tool_assigned_to_non_admin_user
    # bad because for non-admin user user_id gets assigned after saving
    # for admin, user_id gets assigned in form, so before create method is called
    # as a result can't just validate on user's role but have to use attributes
    # of the tool trying to be created, i.e. self
    if self.user_id && User.find(self.user_id).role == "admin"
      errors.add(:user_id, "You must select a non-admin user.")
    end
  end
end
