class Order < ActiveRecord::Base

  after_create { |order| adjust_quantity(order) }

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private
  def adjust_quantity(order)
    order.line_items.each do |item|
      new_quantity = item.product.quantity - item.quantity
      item.product.update(quantity: new_quantity)
    end
  end
end
