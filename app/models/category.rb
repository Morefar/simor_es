class  Category < ActiveRecord::Base
  validates :name, :uniqueness => true, :length => {
    :within => (2..20)
  }
end
