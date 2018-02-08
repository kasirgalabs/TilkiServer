class CoursesController < ApplicationController
before_action :find_course, only: [:show, :edit, :update, :destroy]

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
      Rails.logger.debug("My object: #{@courseStudents.inspect}")
      render 'teacher_show'
    elsif student_signed_in?
      render 'student_show'
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
end
