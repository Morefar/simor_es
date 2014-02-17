# ## Schema Information
#
# Table name: `builds`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`kind_id`**     | `integer`          |
# **`body_id`**     | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class Build < ActiveRecord::Base
  belongs_to :kind
  belongs_to :body

  validates :body_id, :kind_id, presence: true
  validates :kind_id, uniqueness: { scope: :body_id}


  def self.authorized_build? (kind, body)
    return Build.where(body_id: body, kind_id: kind).exists?
  end
end
