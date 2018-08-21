class Order < ActiveRecord::Base

  after_create { |order| adjust_quantity(order) }

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private
  def adjust_quantity(order)
    order.line_items.each do |item|
      product = Product.find_by(id: item.product.id)
      quantity = product.quantity - item.quantity
      product.update(quantity: quantity)
    end
  end
end
