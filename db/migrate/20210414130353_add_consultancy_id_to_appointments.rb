class AddConsultancyIdToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_reference :appointments, :consultancy, null: false, foreign_key: true
  end
end
