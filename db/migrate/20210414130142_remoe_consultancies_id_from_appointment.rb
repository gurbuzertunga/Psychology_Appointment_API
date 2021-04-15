class RemoeConsultanciesIdFromAppointment < ActiveRecord::Migration[6.1]
  def change
    remove_column :appointments, :consultancies_id
  end
end
