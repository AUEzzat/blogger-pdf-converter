class AddHostTypeToComment < ActiveRecord::Migration
  def change
    add_column :comments, :host_type, :string
  end
end
