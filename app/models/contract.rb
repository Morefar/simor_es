class Contract < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :category
  validates_associated :category
  #validates :number, :uniqueness => true
  validates :total_value, :numericality => {:greater_than => 0}
end
