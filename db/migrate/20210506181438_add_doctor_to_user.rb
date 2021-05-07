class AddDoctorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :doctor, :boolean
  end
end
