class ChargesController < ApplicationController
  skip_before_action  :verify_authenticity_token, :authenticate_user!

  def new
    skip_authorization
  end

  def create
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken],
    )

    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [{plan: params[:plan]}],
    })

    current_user.subscribed = true
    current_user.stripe_id = customer.id
    current_user.stripe_subscription_id = subscription.id
    current_user.save
    skip_authorization

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def cancel_plan
    subscription = Stripe::Subscription.retrieve(current_user.stripe_subscription_id)
    subscription.delete
    current_user.subscribed = false
    current_user.save
    skip_authorization
  end
end


