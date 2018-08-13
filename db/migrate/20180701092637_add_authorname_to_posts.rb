class AddAuthornameToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :a_name, :string
  end
end
