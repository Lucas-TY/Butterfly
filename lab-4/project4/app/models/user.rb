class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_one :operating
  has_many :plans,:dependent => :destroy
  has_many :subjects, through: :plans
  has_one :student, required: false, :dependent => :destroy
  has_one :instructor, required: false, :dependent => :destroy

end
