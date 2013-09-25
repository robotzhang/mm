class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: true

  ACCESSABLE_ATTRS = [:name, :password, :password_confirm, :email]

  def has_role?(role)
    self.role == role.to_s
  end
end
