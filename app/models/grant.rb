class Grant < ActiveRecord::Base
  attr_accessible :right, :role
  belongs_to :role
  belongs_to :right
end
