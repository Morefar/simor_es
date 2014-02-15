class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, :commentable_id, :commentable_type, presence: true, on: :update
  validates :content, presence: true, on: :create
  default_scope { order("created_at DESC") }
end
