Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.configure do |events|
  events.all do |event|
    if event.type == 'customer.subscription.created'
      subscription = event.data.object
      user = User.where('stripe_id LIKE ?', "%#{subscription['customer']}%").first
    if user
      customer = Stripe::Customer.retrieve(JSON.parse(user.stripe_id)['id'])
      plan =
      user.stripe_id = customer.to_json
      user.save
    end
  end
    end
end


# StripeEvent.configure do |events|
#   events.subscribe "invoice.payment_failed" do |event|
#     stripe_customer_id = user.event.data.object.customer
#     user = User.find_by(stripe_id: stripe_customer_id)
#   end
# end



