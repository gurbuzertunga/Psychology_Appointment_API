class ChangeTimeOnAppointment < ActiveRecord::Migration[6.1]
  def change
    change_column :appointments, :time, :string
  end
end
