class AppointmentsController < ApplicationController
  before_action :set_consultancy
  before_action :set_appointment, only: [:show, :update, :destroy]

  def index
    json_response(@consultancy.appointments)
  end

  def show
    json_response(@appointment)
  end

  def create
    @consultancy.appointments.create!(appointment_params)
    json_response(@appointment, :created)
  end

  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointment_params
    params.permit(:date, :time, :problem, #:consultancy_id maybe?#)
  end

  def set_consultancy
    @consultancy = Consultancy.find(params[:id])
  end

  def set_appointment
    @appointment = @consultancy.appointments.find_by!(id: params[:id]) if @consultancy
  end
end
