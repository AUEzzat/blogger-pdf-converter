class Comment < ActiveRecord::Base
		belongs_to :host, polymorphic: true
		default_scope -> { order(created_at: :desc) }
end
