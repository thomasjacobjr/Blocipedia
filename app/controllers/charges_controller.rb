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

    current_user.update_attributes(
      stripe_id: customer.id,
      role: :premium,
    )

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
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    # To do - make sure we have a subscription before accessing id
    subscription_id = customer.subscriptions.data.first.id
    customer.subscriptions.retrieve(subscription_id).delete


    current_user.update_attributes(role: :standard)

    flash[:notice] = "Your account has been successfully downgraded."
    redirect_to edit_user_registration_path

  end
end
