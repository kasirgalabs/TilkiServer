class TestAnswer < ApplicationRecord
    belongs_to :test_question
    belongs_to :student
end
