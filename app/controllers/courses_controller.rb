class CoursesController < ApplicationController
before_action :find_course, only: [:show, :edit, :update, :destroy]
before_action :check_user, only: [:show]

  def show
    if teacher_signed_in?
      @courses = Course.all
      @records = CourseStudent.where(:course_id => @course.id)
      @studentCount = @records.count
      @examCount = Exam.where(:course_id => @course.id).count
      @exams = Exam.where(:course_id => @course.id)

      if @records.nil?
        @courseStudents = nil  
      else
        #@courseStudents = Student.where(:id => @records.student_id).take
      end
      render 'teacher_show'
    elsif student_signed_in?
      @courses = Course.all
      @records = CourseStudent.where(:course_id => @course.id)
      @studentCount = @records.count
      @examCount = Exam.where(:course_id => @course.id).count
      @exams = Exam.where(:course_id => @course.id)
      @examResults = ExamResult.where(:course_id => @course_id)

      render 'student_show'
    else
      redirect_to root_path
    end
  end
  
  
  def upload_result
    result = params[:result]
    exam_id = params[:exam_id]
    course_id = params[:course_id]
    
    begin
    resultName = result.original_filename
    resultName.gsub! ' ', '_'
  
    result_url = 'https://s3.eu-central-1.amazonaws.com/tilki/uploads/zipfiles/' + resultName
    @result = ExamResult.new(:name => resultName, :exam_id => exam_id , :course_id => course_id, :result_url => result_url)
    
    if @result.save
      uploader = AvatarUploader.new
      uploader.store!(result)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    
    rescue => ex
      redirect_back(fallback_location: root_path)
    end
    
  end
  
  def remove_result
      result_id = params[:result_id]
      result = ExamResult.find(result_id)
      uploader = AvatarUploader.new
      uploader.retrieve_from_store!(result.name)
      uploader.remove!
      
      if result.destroy
        redirect_back(fallback_location: root_path)
      else
        redirect_to root_path
      end
  end
  
  
  
  def new
    if teacher_signed_in?
      @course = Course.new
    elsif student_signed_in?
      redirect_to students_index_path
    else
      redirect_to root_path
    end
  end
  
  def create
    if teacher_signed_in?
      @course = current_teacher.courses.build(course_params) 
      if @course.save
        redirect_to @course
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end
  
  def edit
    if teacher_signed_in?
      render 'edit'
    elsif student_signed_in?
      redirect_to students_index_path
    else
      redirect_to root_path
    end
  end
  
  def update
    if teacher_signed_in?
      if @course.update(course_params)
        redirect_to @course
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end
  
  def destroy
    if teacher_signed_in?
      @course.destroy
      redirect_to teachers_my_courses_path
    else
      redirect_to root_path
    end
  end
  
  
  def unenroll
    if teacher_signed_in?
      redirect_to root_path
    else
      st = CourseStudent.where(:student_id => current_student.id, :course_id => params[:id]).take
      st.destroy
      redirect_to root_path
    end
  end
  
  def index
    if student_signed_in?
      @courses = Course.all
    else
      redirect_to teachers_index_path
    end
  end
  
  def enroll
    if student_signed_in?
      if CourseStudent.exists?(course_id: params[:id], student_id: current_student.id)
        redirect_to course_path
      else
        @courseStudent = CourseStudent.create(course_id: params[:id], student_id: current_student.id)
        if @courseStudent.save
          redirect_to course_path
        else
          redirect_to root_path
        end
      end
    else
      redirect_to root_path
    end
  end
  
  private
    def course_params
      params.require(:course).permit(:name, :description)
    end
    
    def find_course
      @course = Course.find(params[:id])
    end
    
    def check_user
      if teacher_signed_in?
        if Course.where(:teacher_id => current_teacher.id, :id => params[:id]).take.nil?
          redirect_to root_path
        end        
      end
    end
end
