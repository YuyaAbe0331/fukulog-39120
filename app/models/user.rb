class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :garments
  validates :nickname, presence: true
  validates :sex_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :password,format: { with: /\A[a-z0-9]+\z/i }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sex
  belongs_to :height
  belongs_to :weight

end
