class Inventory < ActiveRecord::Base
attr_accessible :kilometers, :villare, :glove_compartment, :dashboard, :right_seat, :left_seat, :back_seat, :third_row, :courtesy_light, :seat_belt, :radio_brand, :cd_player, :speakers, :lighter, :ash_trays, :clock, :door_panels, :rearview_mirrors, :head_rest, :handles, :horn, :side_mirrors, :warranty_book, :driver_manual, :ignition, :battery, :engine_operation, :uniq_form, :tax_receipt, :lights, :directional_signals, :external_fog_lights, :blind, :front_bumper, :hood, :wiper_blades, :front_right_fender, :front_right_door, :back_right_door, :right_stirrup, :back_right_fender, :back_bumper, :trunk_door, :back_left_fender, :back_left_door, :front_left_door, :left_stirrup, :canvas_hood, :top, :jack, :bolt_wrench, :tool_kit, :tool_keys, :front_tires, :back_tires, :spare_tires, :common_rims, :luxury_rims, :cups, :front_windshield, :front_right_window, :rear_right_window, :third_rear_right_window, :rear_windshield, :rear_left_window, :front_left_window, :third_rear_left_window, :air_conditioner, :electric_windows, :central_block, :sun_roof, :luxury_steering_wheel, :floor_mats, :triangles, :first_aid_kit, :leather_upholstery, :pijama, :trunk_cover, :celular_phone, :electric_antena, :antena, :observations

  belongs_to :inspection

  validates :speakers, :ash_trays, :door_panels, :rearview_mirrors, :head_rest, :side_mirrors, :tool_kit, :tool_keys, :common_rims, :luxury_rims, :cups, :electric_windows, :central_block, :floor_mats, :triangles, numericality: { only_integer: true,
                      greater_than_or_equal_to: 0 }

end
