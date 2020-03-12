class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account, required: false

  delegate :number, to: :account, prefix: true
  delegate :balance, to: :account, prefix: true

  def fullname
    "#{first_name} #{last_name}"
  end
end
