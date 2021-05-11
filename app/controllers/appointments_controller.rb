class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  def index
    if current_user.doctor === true
      @appointments = Appointment.all
      Appointment.all.each do |appointment|
        @username = appointment.user.name
      end
    else
      @appointments = current_user.appointments
      Appointment.all.each do |appointment|
        @username = appointment.user.name
      end
    end
    
    json_response(appointments: @appointments, username: @username)
  end

  def show
    json_response(@appointment)
  end

  def create
    @appointment = current_user.appointments.create!(appointment_params)
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
    params.permit(:time, :problem, :date, :consultancy_id, :user_id)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
