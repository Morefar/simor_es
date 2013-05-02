class Asset < ActiveRecord::Base
  belongs_to :contract, inverse_of: :assets

end
