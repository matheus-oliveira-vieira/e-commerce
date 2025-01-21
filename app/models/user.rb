class User < ApplicationRecord
  validates :name, :email, :cpf, presence: true
end
