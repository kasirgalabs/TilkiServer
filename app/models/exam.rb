class Exam < ApplicationRecord
    belongs_to :course
    has_many :classic_question
    has_many :test_question
end
