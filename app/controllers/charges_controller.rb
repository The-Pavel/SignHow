class ChargesController < ApplicationController
  skip_before_action  :verify_authenticity_token, :authenticate_user!
  attr_accessor :stripe_card_token


  def new
    if user_signed_in? && current_user.subscribed?
      redirect_to root_path, notice: "You are already subscribed"
    end
    skip_authorization
  end

  def create
    # Stripe.api_key = Rails.application.credentials.stripe_api_key
    # customer = Stripe::Customer.create(
    #   :email => params[:stripeEmail],
    #   :source  => params[:stripeToken]
    # )

    # subscription = Stripe::Subscription.create({
    #   customer: customer.id,
    #   :plan_id => params[:plan_id]
    # })
    plan_id = 'plan_CqDMOVy8qGmsdb'
    plan = Stripe::Plan.retrieve(plan_id)
    stripe_card_token = params[:stripeToken]

    customer = Stripe::Customer.create(:email => params[:stripeEmail], source: stripe_card_token)


    subscription = Stripe::Subscription.create({
      customer: customer.id,
      :plan => plan_id
    })

    # current_user.subscribed = true
    # current_user.stripe_id = customer.id
    # current_user.stripe_subscription_id = subscription.id
    # current_user.save
    options = {
      stripe_id: customer.id,
      stripe_subscription_id: subscription.id,
      subscribed: true
    }

    current_user.update(options)
    skip_authorization

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def cancel_plan
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    Stripe::Subscription.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(subscribed: false, stripe_subscription_id: nil)
    redirect_to root_path, notice: "Your subscription has been cancelled"
    skip_authorization
  end
end


