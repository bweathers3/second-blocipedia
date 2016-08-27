class User < ActiveRecord::Base

  has_many :wikis, dependent: :destroy

  after_initialize :init

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def init
     self.role  ||= 0
  end

  enum role: [:standard, :premium, :admin]

end
