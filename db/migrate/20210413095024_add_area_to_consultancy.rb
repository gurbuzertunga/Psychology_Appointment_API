class AddAreaToConsultancy < ActiveRecord::Migration[6.1]
  def change
    add_column :consultancies, :area, :string
  end
end
