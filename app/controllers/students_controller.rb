class StudentsController < ApplicationController
  def index
  end
  
  def my_courses
    @my_courses = CourseStudent.joins(:course).where(student_id: current_student.id)
  end
  
  def exam_dates
    #In here exam dates of current student should be passed through view
    #The data of calendar inside javascript will be taken from the passed exam date parameter
  end
end
