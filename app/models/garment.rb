class Garment < ApplicationRecord
  validates :image, presence: true, unless: :was_attached?
  validates :name, presence: true
  validates :genre_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :brand, presence: true
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :category

  def was_attached?
    image.attached?
  end
end
