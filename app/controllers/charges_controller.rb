class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create (
      email: current_user.email,
      card: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Lorbo - #{current_user.email}",
      currency: 'usd'
    )

    current_user.role = :premium

    flash[:notice] = "Thanks for all the money, #{current_user.email}! You are now a Premium Lorbo."
    redirect_to user_path(current_user)

  rescue Stripe::CardError => elephant
    flash.now[:alert] = elephant.message
    redirect_to new_charge_path
  end
end
