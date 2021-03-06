class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user_id, presence: { message: "must be logged in" }
  validates :product_id, presence: true
  validates :description, presence: true
  validates :rating, presence: true
end
