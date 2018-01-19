class Student < ApplicationRecord
  has_many :course_student
  has_many :test_answer
  has_many :classic_answer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
