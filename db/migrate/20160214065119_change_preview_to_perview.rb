class ChangePreviewToPerview < ActiveRecord::Migration
  def change
  	rename_column :images, :perview, :preview
  end
end
