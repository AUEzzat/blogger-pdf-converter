class RemoveLikedFromLike < ActiveRecord::Migration
  def change
    remove_column :likes, :liked, :boolean
  end
end
