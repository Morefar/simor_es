class Inventory < ActiveRecord::Base
  belongs_to :inspection
  # attr_accessible :title, :body
end
