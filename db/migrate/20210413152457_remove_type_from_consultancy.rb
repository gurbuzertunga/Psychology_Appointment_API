class RemoveTypeFromConsultancy < ActiveRecord::Migration[6.1]
  def change
    remove_column :consultancies, :type
  end
end
