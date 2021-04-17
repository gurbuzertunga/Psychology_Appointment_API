class AddUserIdToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_reference :appointments, :user, foreign_key: true
  end
end
