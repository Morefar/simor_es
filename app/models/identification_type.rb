class IdentificationType < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
