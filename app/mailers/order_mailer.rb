class OrderMailer < ApplicationMailer

  def email_receipt(order)
    @order = order
    mail(to: @order.email, subject: "Jungle - Receipt for Order ##{@order.id}")
  end
end
