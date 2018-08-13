class AddLNameToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :l_name, :string
  end
end
