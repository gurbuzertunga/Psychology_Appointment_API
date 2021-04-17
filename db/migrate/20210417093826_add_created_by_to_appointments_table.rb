class AddCreatedByToAppointmentsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :created_by, :string
  end
end
