class Micropost < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  scope :sort_feed , ->{order created_at: :desc}

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
end
