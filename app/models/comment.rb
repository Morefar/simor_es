class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :commentable_id, :commentable_type
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, :commentable_id, :commentable_type, presence: true
end
