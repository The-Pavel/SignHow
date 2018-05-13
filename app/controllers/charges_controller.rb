class ChargesController < ApplicationController
  def new
    skip_authorization
  end

  def create
    # Amount in cents

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )



    # charge = Stripe::Charge.create(
    #   :customer    => customer.id,
    #   :amount      => params[:amount],
    #   :description => 'Rails Stripe customer',
    #   :currency    => 'usd'
    # )

    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [{plan: params[:plan]}],
    })

    skip_authorization
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end


