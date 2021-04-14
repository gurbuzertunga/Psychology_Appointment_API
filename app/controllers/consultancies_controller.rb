class ConsultanciesController < ApplicationController
  before_action :set_consultancy, only %i[show update destroy]

  def index
    @consultancies = Consultancy.all
    json.response(@consultancies)
  end
  
  def create
    @consultancy = Consultancy.create!(consultancy_params)
    json_response(@consultancy, :created)
  end

  def show
    json_response(@consultancy)
  end

  def update
    @consultancy.update(consultancy_params)
    head: no_content
  end

  def destroy
    @consultancy.destroy
    head: no_content
  end

  private

  def consultancy_params
    params.permit(:area)
  end

  def set_consultancy
    @consultancy = Consultancy.find(params[:id])
  end
end
