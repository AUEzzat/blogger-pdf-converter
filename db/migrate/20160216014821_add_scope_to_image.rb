class AddScopeToImage < ActiveRecord::Migration
  def up
    add_column :images, :scope, :string
    add_index :images, :scope
  end
  def down
  end
end
