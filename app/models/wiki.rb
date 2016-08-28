class Wiki < ActiveRecord::Base

  belongs_to :user

  after_initialize :init_wiki

  def init_wiki
     self.private  ||= false
  end

end
