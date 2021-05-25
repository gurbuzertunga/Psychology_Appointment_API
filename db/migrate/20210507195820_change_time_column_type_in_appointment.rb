class ChangeTimeColumnTypeInAppointment < ActiveRecord::Migration[6.1]
  def change
    change_column :appointments, :date, :string
  end
end
