class User < ActiveRecord::Base

  has_many :wikis, dependent: :destroy

  has_many :collaborators

  has_many :collaborating_wikis, through: :collaborators, source: :wiki


  after_initialize :init

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def init
     self.role  ||= 0
  end

  enum role: [:standard, :premium, :admin]

end
