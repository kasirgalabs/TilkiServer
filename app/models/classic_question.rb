class ClassicQuestion < ApplicationRecord
    belongs_to :exam
    has_many :classic_answer
end
