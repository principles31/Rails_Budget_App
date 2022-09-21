class Category < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :transactions, foreign_key: 'category_id', class_name: 'Transaction'

  validates :name, presence: true, length: { maximum: 255 }
  has_one_attached :icon

  def total_amount
    transactions.sum(:amount)
  end
end
