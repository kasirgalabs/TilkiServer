class Exam < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 16 }
end
