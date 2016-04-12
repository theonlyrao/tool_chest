class Tool < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  belongs_to :user
end
