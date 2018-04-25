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
      @student = Student.where(:name => student_name, :surname => student_surname, :number => student_number).take
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
    key = params[:key].to_i
    
    begin
      @exam = Exam.where(:name => exam_name).take
      if @exam.instructor_key != key
        puts 'sa burdayim'
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
      rpSkor = params[:rpSkor].to_i
      fdSkor = params[:fdSkor].to_i
      md5code = params[:hash]
      usbstate = params[:usbState]
      
      zipname = zipFile.original_filename
      
      if zipname.start_with?('code')
        file_type = "Exam File"
      else
        file_type = "Security File"
      end
      
      exam_id = Exam.where(:name => exam).take.id
      student_id = Student.where(:number => number).take.id
      
      zipname.gsub! ' ', '_'
      
      file_url = 'https://s3.eu-central-1.amazonaws.com/tilki/uploads/zipfiles/' + zipname
      
      if exam_id.nil? || student_id.nil?
        #Do nothing
      else
        if(SecurityScore.where(:exam_id => exam_id, :student_id => student_id, :rpskor => rpSkor, :fdskor => fdSkor).take.nil?)
          @securityScore = SecurityScore.new(:exam_id => exam_id, :student_id => student_id, :rpskor => rpSkor, :fdskor => fdSkor, :usbstate => usbstate)
          @securityScore.save
        end
        
        if(UploadedFile.where(:exam_id => exam_id, :student_id => student_id, :filetype => file_type).take.nil?)
          @file = UploadedFile.new(:exam_id => exam_id, :student_id => student_id, :filetype => file_type, :file_url => file_url, :md5code => md5code)
        else
          @file = UploadedFile.where(:exam_id => exam_id, :student_id => student_id, :filetype => file_type).take
          @file.update_column(:md5code, md5code)
        end
        
        if @file.save
          uploader = AvatarUploader.new
          uploader.store!(zipFile)
        else
          #do nothing
        end
      end

  end
end
