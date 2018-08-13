class AddCountryToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :country, :string
  end
end
