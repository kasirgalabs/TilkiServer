class TeachersController < ApplicationController
  def index

  end
  
  def my_courses
    @my_courses = Course.where(:teacher_id => current_teacher.id)
  end
  
  def exam_dates
    @cs = Course.where(:teacher_id => current_teacher.id)
    Rails.logger.debug("cs: #{@cs.inspect}")
    @exams = Exam.where(:course_id => @cs.map(&:id))
    Rails.logger.debug("exams: #{@exams.inspect}")
    @dates =  @exams.map(&:start_time).to_s
    @names =  @exams.map(&:name)
    Rails.logger.debug("dates: #{@dates.inspect}")
  end
end
