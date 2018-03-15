class ExamsController < ApplicationController
  before_action :find_exam, only: [:show, :edit, :update, :destroy]

  def show
    if teacher_signed_in?
      @file = UploadedFile.where(:exam_id => @exam.id).all
      @questions = ExamPaper.where(:exam_id => @exam_id).all
      render 'teacher_show'
    elsif student_signed_in?
      render 'student_show'
    else
      redirect_to root_path
    end
  end
  
  def upload
    paper = params[:paper]
    exam_id = params[:exam_id]
    @exam = Exam.find(exam_id)
    paperName = paper.original_filename
    paper_url = 'https://s3.eu-central-1.amazonaws.com/tilki/uploads/zipfiles/' + paperName
    @paper = ExamPaper.new(:exam_id => exam_id , :file_url => paper_url)
    @file = UploadedFile.where(:exam_id => @exam.id).all
      
      if @paper.save
        uploader = AvatarUploader.new
        uploader.store!(paper)
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
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
