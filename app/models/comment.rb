# ## Schema Information
#
# Table name: `comments`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `integer`          | `not null, primary key`
# **`content`**           | `text`             |
# **`user_id`**           | `integer`          |
# **`commentable_id`**    | `integer`          |
# **`commentable_type`**  | `string(255)`      |
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, :commentable_id, :commentable_type, presence: true, on: :update
  validates :content, presence: true, on: :create
  default_scope { order("created_at DESC") }
end
