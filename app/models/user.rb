class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  after_create :create_cart
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :cpf, presence: true

  private

  def create_cart
    Cart.create(user: self)
  end
end
