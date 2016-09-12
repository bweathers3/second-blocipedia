class Wiki < ActiveRecord::Base

  attr_accessor :collaborator_email, :collaborator_drop

  belongs_to :user
  #belongs_to :creator, class_name: 'User', foreign_key: :user_id

  has_many :collaborators

  has_many :collaborating_users, through: :collaborators, source: :user

  after_initialize :init_wiki

  def init_wiki
     self.private = false if self.private.nil?
  end

end
