class ExamResult < ApplicationRecord
    belongs_to :course
    belongs_to :student
    belongs_to :exam
end
