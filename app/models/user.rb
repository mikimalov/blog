class User < ApplicationRecord
  # include Clearance::User

  MAXIMUM_NAME_LENGTH = 255
  MAXIMUM_EMAIL_LENGTH = 50
  MINIMUM_PASSWORD_LENGTH = 6
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_secure_password
  #dava attr_accessor :password , :password_confirmation argumenti
  # kolona password_digest treba
  #dava metod authenticate, za proverka na passwordot koa ke go vnesuva korisnik

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save :email_to_downcase

  validates :name, presence: true, length: { maximum: MAXIMUM_NAME_LENGTH }
  validates :email, presence: true, length: { maximum: MAXIMUM_EMAIL_LENGTH },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: MINIMUM_PASSWORD_LENGTH }

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
