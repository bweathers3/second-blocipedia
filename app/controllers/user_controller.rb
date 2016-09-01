class UserController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    current_user.role = 'standard'
    #current_user.role = 'premium'
    current_user.save

  end

end
=begin
     @user = current_user

     @user.assign_attributes(@user_params)
     @user.role = 'premium'

     if @user.save
       flash[:notice] = "Your account was updated successfully."
       redirect_to root_path
     else
       flash.now[:alert] = "Error saving your account changes. Please try again."
       render :edit
     end
   end
=end
