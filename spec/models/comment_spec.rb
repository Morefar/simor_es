require 'rails_helper'

describe Comment do
  it { should belong_to(:user) }
  it { should belong_to(:commentable) }
end

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
