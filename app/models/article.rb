class Article < ApplicationRecord
  MINIMUM_PASSWORD_LENGTH = 5

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { minimum: MINIMUM_PASSWORD_LENGTH }
end
