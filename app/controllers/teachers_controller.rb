class TeachersController < ApplicationController
  def index
  end
  
  def my_courses
    @my_courses = Course.where(:teacher_id => current_teacher.id)
  end
  
  def exam_dates
    #In here exam dates of current teacher should be passed through view
    #The data of calendar inside javascript will be taken from the passed exam date parameter
  end
end
