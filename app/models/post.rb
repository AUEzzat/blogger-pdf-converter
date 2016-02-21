class Post < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  validates :title, presence: true, uniqueness: true 
  validates :slide, presence: { message:"Please choose PDF file before attempting to create post" }
  has_many :comments, as: :host, dependent: :destroy
  has_many :likes, as: :host, dependent: :destroy
  has_many :images, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  
  mount_uploader :slide, SlideUploader

  friendly_id :title, use: :slugged

end
