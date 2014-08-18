require 'rails_helper'

describe Document, :type => :model do
  skip "add some examples to (or delete) #{__FILE__}"
end

# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                      | Type               | Attributes
# ------------------------- | ------------------ | ---------------------------
# **`id`**                  | `integer`          | `not null, primary key`
# **`content`**             | `string(255)`      |
# **`slug`**                | `string(255)`      |
# **`md5hash`**             | `string(255)`      |
# **`content_type`**        | `string(255)`      |
# **`file_size`**           | `string(255)`      |
# **`category`**            | `string(255)`      |
# **`documentable_id`**     | `integer`          |
# **`documentable_type`**   | `string(255)`      |
# **`created_at`**          | `datetime`         | `not null`
# **`updated_at`**          | `datetime`         | `not null`
# **`content_processing`**  | `boolean`          |
#
