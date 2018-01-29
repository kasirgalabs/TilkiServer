class StaticPagesController < ApplicationController
    def home
        if teacher_signed_in?
            redirect_to teachers_index_path
        end
        
        if student_signed_in?
            redirect_to student_index_path
        end
    end
end
