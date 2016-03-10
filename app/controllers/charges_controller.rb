class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken],
      plan: "premium"
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Lorbo - #{current_user.email}",
      currency: 'usd'
    )

    current_user.role = :premium

    flash[:notice] = "Thanks for all the money, #{current_user.email}! You are now a Premium Lorbo."
    redirect_to edit_user_registration_path

  rescue Stripe::CardError => elephant
    flash.now[:alert] = elephant.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Lorbo - #{current_user.email}",
      amount: Amount.default
    }
  end

  def destroy 

  end
end
