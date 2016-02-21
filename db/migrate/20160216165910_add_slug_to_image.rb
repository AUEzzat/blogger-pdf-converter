class AddSlugToImage < ActiveRecord::Migration
  def change
    add_column :images, :slug, :string
  end
end
