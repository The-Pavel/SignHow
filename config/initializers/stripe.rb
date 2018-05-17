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
      # plan = customer.subscriptions.data[0].items.data[0].plan.id
      user.stripe_id = customer.to_json
      user.save
    end
  end
    end
end





