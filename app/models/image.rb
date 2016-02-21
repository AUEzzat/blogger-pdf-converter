class Image < ActiveRecord::Base
	extend FriendlyId
	belongs_to :post
	has_many :comments, as: :host, dependent: :destroy
	has_many :likes, as: :host, dependent: :destroy
	default_scope -> { order(number: :asc) }

	friendly_id :number, use: :scoped, scope: :post
end
