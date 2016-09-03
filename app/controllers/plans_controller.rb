class PlansController < ApplicationController
  def edit
    downgrade
  end


private
  def downgrade
    new_role = 'standard'
    current_user.role = new_role
  end


end
