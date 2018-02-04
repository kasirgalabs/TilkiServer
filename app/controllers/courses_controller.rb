class CoursesController < ApplicationController
before_action :find_course, only: [:show, :edit, :update, :destroy]
  def index
    if teacher_signed_in?
      @courses = Course.where(:teacher_id => current_teacher.id).order("created_at DESC")
    end
  end
  
  def show
  
  end
  
  def new
    if teacher_signed_in?
      @course = Course.new
    else
      redirect_to teachers_my_courses_path
    end
  end
  
  def create
    @course = current_teacher.courses.build(course_params) 
    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end
  
  def destroy
    @course.destroy
    redirect_to teachers_my_courses_path
  end
  
  def enroll
    
  end
  
  private
    def course_params
      params.require(:course).permit(:name, :description)
    end
    
    def find_course
      @course = Course.find(params[:id])
    end
end
