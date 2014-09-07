class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :last_name, :first_name, :timezone, :locale
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :last_name, :first_name, :timezone, :locale, :confirmed_at, :confirmation_token, :unconfirmed_email, :admin, :as => :admin
  ## VALIDATIONS
  #
  validates_presence_of :email, :username, :first_name, :last_name

  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :last_name, :case_sensitive => false
  validates_uniqueness_of :first_name, :case_sensitive => false

  ## Associations
  #

  has_many :location_users
  has_many :locations, :through => :location_users

  scope :admins, where(:admin => true)

end
