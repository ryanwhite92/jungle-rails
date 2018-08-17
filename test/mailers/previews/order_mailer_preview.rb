class OrderMailerPreview < ActionMailer::Preview
  def email_receipt
    OrderMailer.email_receipt(Order.last)
  end
end