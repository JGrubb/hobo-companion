class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:rpx_connectable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name
  # attr_accessible :title, :body
  has_and_belongs_to_many :shows

  scope :active, -> { where('last_sign_in_at > ?', 1.year.ago) }

  
  def self.bump_karma(points, user)
    @user = self.find(user.id)
    @user.karma += points
    @user.save
  end
end
