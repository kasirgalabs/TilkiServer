class ExamsController < ApplicationController
  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find(params[:id])
  end

  def new
    @exam = Exam.new
  end

  def edit
    @exam = Exam.find(params[:id])
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to @exam
    else
      render 'new'
    end
  end

  def update
    @exam = Exam.find(params[:id])

    if @exam.update(exam_params)
      redirect_to @exam
    else
      render 'edit'
    end
  end

  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy

    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit(:name, :description)
  end
end
