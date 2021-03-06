class UserController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    downgrade_plan
    downgrade_wikis
    flash[:notice] = "Your subscription has been downgraded to Standard, #{current_user.email}! You may upgrade again at any time."
    redirect_to root_path
  end


 private

  def downgrade_plan
    current_user.role = 'standard'
    current_user.save
  end

  def downgrade_wikis
    @wikis = Wiki.all
    @wikis.each do |w|
      if current_user.id  == w.user_id
          w.private = false
          w.save
      end
   end
 end
end
