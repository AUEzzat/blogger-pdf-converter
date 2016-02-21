class AddDefaultToLike < ActiveRecord::Migration
  def change
  	change_column :likes, :liked, :boolean, :default => false
  	change_column :likes, :like_count, :integer, :default => 0
  end
end
