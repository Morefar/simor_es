class Inventory < ActiveRecord::Base
  belongs_to :inspection
  validates :speakers, :ash_trays, :door_panels, :rearview_mirrors, :head_rest, :side_mirrors, :tool_kit, :tool_keys, :common_rims, :luxury_rims, :cups, :electric_windows, :central_block, :floor_mats, :triangles, numericality: { only_integer: true,
                      greater_than_or_equal_to: 0 }

end
