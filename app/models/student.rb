class Student < ApplicationRecord
    belongs_to :course_student
    has_many :test_answer
    has_many :classic_answer
end
