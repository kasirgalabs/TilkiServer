class ExamsController < ApplicationController
  before_action :find_exam, only: [:show, :edit, :update, :destroy]

  def show
    
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
      if @exam.update(exam_params)
        redirect_to @exam
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end
  
  def destroy
    if teacher_signed_in?
      @exam.destroy
      redirect_to Course.find(params[:course_id])
    else
      redirect_to root_path
    end
  end
  
  def index
    @exams = Exam.all
  end
  
  
  def new
    if teacher_signed_in?
      @exam = Exam.new
    elsif student_signed_in?
      redirect_to students_index_path
    else
      redirect_to root_path
    end
  end
  
  def create
    if teacher_signed_in?
      @exam = Course.find(params[:course_id]).exams.build(exam_params)
      if @exam.save
        redirect_to Course.find(params[:course_id])
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end
  
  private
    def exam_params
      params.require(:exam).permit(:name, :course_id, :start_time, :finish_time)
    end
    
    def find_exam
      @exam = Exam.find(params[:id])
    end

end
