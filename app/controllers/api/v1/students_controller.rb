class Api::V1::StudentsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery unless: -> { request.format.json? }

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.json { render json: @student.to_json }
      else
        format.json { render json: { errors: @student.errors.full_messages } }
      end
    end
  end

  private
  def student_params
    params.require(:student).permit(:name, :surname, :number)
  end
end
