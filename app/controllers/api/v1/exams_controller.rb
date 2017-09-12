class Api::V1::ExamsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery unless: -> { request.format.json? }

  def index
    respond_to do |format|
      format.json { render json: Exam.all }
    end
  end
end
