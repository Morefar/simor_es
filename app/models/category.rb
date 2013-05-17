class  Category < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  validates :name, :uniqueness => true
  validates :name, :length => { :within => (2..20) }
  validates :name, format: {
    with: /\A[a-zA-Z\s]+\z/,
    message: "Only letters allowed"
  }
end
