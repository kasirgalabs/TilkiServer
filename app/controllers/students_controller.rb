class StudentsController < ApplicationController
  def index
  end
  
  def my_courses
    @my_courses = CourseStudent.joins(:course).where(student_id: current_student.id)
  end
  
  def exam_dates
    
    @cs = CourseStudent.where(:student_id => current_student.id)
    Rails.logger.debug("cs: #{@cs.inspect}")
    @exams = Exam.where(:course_id => @cs.map(&:course_id))
    Rails.logger.debug("exams: #{@exams.inspect}")
    @dates =  @exams.map(&:start_time).to_s
    @names =  @exams.map(&:name)
    Rails.logger.debug("dates: #{@dates.inspect}")

  end
end
