class User < ActiveRecord::Base
  attr_accessible :name, :email, :username, :password, :password_confirmation
  has_secure_password

  has_many :stitches, dependent: :destroy

  # OLD METHODS FROM SAMPLE APP #
  # --------------------------- #

  #has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #has_many :followed_users, through: :relationships, source: :followed
  #has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  #has_many :followers, through: :reverse_relationships, source: :follower

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.username = username.downcase }
  before_save :create_remember_token
  before_save :create_api_key

  validates :name,  presence: true, length: { maximum: 50 }

  #VALID_USERNAME_REGEX = //i
  validates :username, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    # feed of stitches?
    #Stitch.from_users_followed_by(self)
    Stitch.all
  end

  #def following?(other_user)
  #  relationships.find_by_followed_id(other_user.id)
  #end
  #
  #def follow!(other_user)
  #  relationships.create!(followed_id: other_user.id)
  #end
  #
  #def unfollow!(other_user)
  #  relationships.find_by_followed_id(other_user.id).destroy
  #end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def create_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
