class Wiki < ActiveRecord::Base

  belongs_to :user

  after_initialize :init_wiki

  def init_wiki
     self.private = false if self.private.nil?
  end

end
