class Student < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
