class ExamResult < ApplicationRecord
  belongs_to :exam
  belongs_to :course
end
