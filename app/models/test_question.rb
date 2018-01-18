class TestQuestion < ApplicationRecord
    belongs_to :exam
    has_many :test_answer
end
