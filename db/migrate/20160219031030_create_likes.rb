class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :host_id
      t.string :host_type
      t.integer :user_id
      t.integer :like_count
      t.boolean :liked

      t.timestamps null: false
    end
  end
end
