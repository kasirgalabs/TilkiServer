class ExamsController < ApplicationController
  before_action :find_exam, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:show]

  def show
    if teacher_signed_in?
      @file = UploadedFile.where(:exam_id => @exam.id).all
      @securityScore = SecurityScore.where(:exam_id => @exam.id).all
      @questions = ExamPaper.where(:exam_id => @exam.id).all
      render 'teacher_show'
    elsif student_signed_in?
        exam_dt = Exam.find(@exam.id).start_time;
        if (exam_dt - DateTime.now.in_time_zone) < 10.minutes
          @questions = ExamPaper.where(:exam_id => @exam.id).all
          render 'student_show'
        else
          redirect_to root_path
        end
    else
      redirect_to root_path
    end
  end
  
  def upload
    paper = params[:paper]
    if paper.nil?
        redirect_back(fallback_location: root_path)
    else
      exam_id = params[:exam_id]
      @exam = Exam.find(exam_id)
      paperName = paper.original_filename
      
      paperName.gsub! ' ', '_'
    
      if ExamPaper.exists?(:name => paperName)
        redirect_back(fallback_location: root_path)
      else
        paper_url = 'https://s3.eu-central-1.amazonaws.com/tilki/uploads/zipfiles/' + paperName
        @paper = ExamPaper.new(:name => paperName, :exam_id => exam_id , :file_url => paper_url)
        @file = UploadedFile.where(:exam_id => @exam.id).all
      
        if @paper.save
          uploader = AvatarUploader.new
          uploader.store!(paper)
          redirect_back(fallback_location: root_path)
        else
          redirect_back(fallback_location: root_path)
        end
      end
    end
  end
  def remove_paper
    name = params[:name]
    paper_id = params[:paper_id]
    uploader = AvatarUploader.new
    uploader.retrieve_from_store!(name)
    uploader.remove!
    
    paperRecord = ExamPaper.find(paper_id)
    if paperRecord.destroy
      redirect_back(fallback_location: root_path)
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
      if @exam.update(exam_params)
        course_id = @exam.course_id
        redirect_to course_exam_path(:course_id => course_id, :id => params[:id])
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
      instructor_key = rand(10000..99999)
      @exam.instructor_key = instructor_key
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
    
    def check_user
      if teacher_signed_in?
        c = Course.find(params[:course_id]).teacher_id
        if c != current_teacher.id
          redirect_to root_path
        end
      end
      
      if student_signed_in?
        if CourseStudent.where(:student_id => current_student.id, :course_id => params[:course_id]).take.nil?
          redirect_to root_path
        end
      end
    end

end
