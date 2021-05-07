class AddDetailsToConsultancies < ActiveRecord::Migration[6.1]
  def change
    add_column :consultancies, :details, :string
  end
end
