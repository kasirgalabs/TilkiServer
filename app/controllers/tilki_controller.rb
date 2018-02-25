class TilkiController < ApplicationController
  
  protect_from_forgery
  skip_before_action :verify_authenticity_token
  
  def list_exams
    date = DateTime.now
    @exams = Exam.where(["finish_time > ?", date])
    respond_to do |format|
      format.json { render json: @exams }
    end
  end
  
  def check_in
    student_name = params[:name]
    student_surname = params[:surname]
    student_number = params[:number]
    exam_name = params[:exam]

    begin
      @exam = Exam.where(:name => exam_name).take
      @course = Course.where(:id => @exam.course_id).take
      @student = Student.where(:name => student_name, :surname => student_surname).take
      record = CourseStudent.where(:course_id => @course.id, :student_id => @student.id).take
      respond_to do |format|
        format.json { render json: 'Record successfully found' }
      end   
    rescue => ex
      respond_to do |format|
        format.json { render json: 'No record found' }
      end    
    end
  end
  
  def verify_key
    exam_name = params[:exam]
    password = params[:key]
    
    begin
      @exam = Exam.where(:name => exam_name).take
      teacher_id = Course.where(:id => @exam.course_id).take.teacher_id
      dbTeacher = Teacher.find(teacher_id)
      @teacher = dbTeacher.valid_password?(password) ? dbTeacher : nil
      
      if @teacher.nil?
        respond_to do |format|
          format.json { render json: 'Instructor not found' }
        end
      else
        respond_to do |format|
          format.json { render json: 'Instructor verified' }
        end      
      end
    
    rescue => ex
        respond_to do |format|
          format.json { render json: 'Instructor not found' }
        end    
    end
  end
  
  
  def upload
      number = params[:number]
      exam = params[:exam]
      zipFile = params[:fileName]
      zipname = zipFile.original_filename


      Rails.logger.debug("My number: #{number.inspect}")
      Rails.logger.debug("My exam: #{exam.inspect}")
      Rails.logger.debug("zipname: #{zipname.inspect}")

      uploader = AvatarUploader.new
      uploader.store!(zipFile)
      
      require 'digest/md5'
      @digest = Digest::MD5.hexdigest(zipname)
  end
end
