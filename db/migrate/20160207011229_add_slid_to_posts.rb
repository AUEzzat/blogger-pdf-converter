class AddSlidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slide, :string
  end
end
