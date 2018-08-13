class AddFNameToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :f_name, :string
  end
end
