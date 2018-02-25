class Course < ApplicationRecord
    belongs_to :teacher
    has_many :course_student
    has_many :exams
end
