class AddPerviewToImage < ActiveRecord::Migration
  def change
    add_column :images, :perview, :string
  end
end
