class HomeController < ApplicationController
  def index
    redirect_to :controller => "exams", :action => "index"
  end
end
