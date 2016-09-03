class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.name}",
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
     description: "Blocipedia Membership - #{current_user.email}",
     currency: 'usd'
   )

   current_user.update_attribute(:role, 'premium')

   if current_user.save!
     flash[:notice] = "Thanks for your subscription, #{current_user.email}! Please let us know if we can help."
     redirect_to root_path
   end

   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
   end

 private

   class Amount
      def self.default
        return 15_00
      end
   end

end
