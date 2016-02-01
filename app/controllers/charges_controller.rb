class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Blocipedia Premium Menbership - #{current_user.email}",
      currency: 'usd'
    )

    user = current_user
    user.upgrade!

    flash[:notice] = "Thanks for upgrading, #{current_user.email}!"
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
      flash.now[:alert] = e.message
      redirect_to new_charge_path
  end
end
