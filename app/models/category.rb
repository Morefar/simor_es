class  Category < ActiveRecord::Base
  attr_accessible :name
  default_scope order(:name)
  validates :name, presence: true
  validates :name, :uniqueness => true
  validates :name, :length => { :within => (2..20) }
  validates :name, format: {
    with: /\A[a-zA-Z\d\s]+\z/
  }
end
