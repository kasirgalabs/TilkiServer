class Course < ApplicationRecord
    has_many :course_student
    has_many :exam
end
