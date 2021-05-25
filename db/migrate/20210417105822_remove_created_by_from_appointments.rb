class RemoveCreatedByFromAppointments < ActiveRecord::Migration[6.1]
  def change
    remove_column :appointments, :created_by
  end
end
