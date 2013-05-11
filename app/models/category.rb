class  Category < ActiveRecord::Base
  validates :name, presence: true
  validates :name, :uniqueness => true, :length => {
    :within => (2..20)
  }
  validates :name, format: {with: /\A[a-zA-Z\s]+\z/,
    message: "Only letters allowed" }
  attr_accessible :name
end
