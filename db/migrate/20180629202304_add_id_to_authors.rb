class AddIdToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :github_id, :string
    add_column :authors, :insta_id, :string
  end
end
