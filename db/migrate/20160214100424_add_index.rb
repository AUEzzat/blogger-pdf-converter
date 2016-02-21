class AddIndex < ActiveRecord::Migration
  def change
  	add_index :comments, :host_id
  end
end
