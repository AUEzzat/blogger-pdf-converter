class AddHostIdToComment < ActiveRecord::Migration
  def up
  	add_column :comments, :host_id, :integer
  end

  def down
  	remove_column :comments, :post_id
  end
end
