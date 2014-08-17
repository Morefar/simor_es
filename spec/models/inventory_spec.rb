require 'rails_helper'

describe Inventory do

  it { should belong_to(:inspection) }

  it 'has a valid factory' do
    expect(build(:inventory)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `inventories`
#
# ### Columns
#
# Name                           | Type               | Attributes
# ------------------------------ | ------------------ | ---------------------------
# **`id`**                       | `integer`          | `not null, primary key`
# **`inspection_id`**            | `integer`          |
# **`kilometers`**               | `boolean`          |
# **`villare`**                  | `boolean`          |
# **`glove_compartment`**        | `boolean`          |
# **`dashboard`**                | `boolean`          |
# **`right_seat`**               | `boolean`          |
# **`left_seat`**                | `boolean`          |
# **`back_seat`**                | `boolean`          |
# **`third_row`**                | `boolean`          |
# **`courtesy_light`**           | `boolean`          |
# **`seat_belt`**                | `boolean`          |
# **`radio_brand`**              | `string(255)`      |
# **`cd_player`**                | `boolean`          |
# **`speakers`**                 | `integer`          |
# **`lighter`**                  | `boolean`          |
# **`ash_trays`**                | `integer`          |
# **`clock`**                    | `boolean`          |
# **`door_panels`**              | `integer`          |
# **`rearview_mirrors`**         | `integer`          |
# **`head_rest`**                | `integer`          |
# **`handles`**                  | `boolean`          |
# **`horn`**                     | `boolean`          |
# **`side_mirrors`**             | `integer`          |
# **`warranty_book`**            | `boolean`          |
# **`driver_manual`**            | `boolean`          |
# **`ignition`**                 | `boolean`          |
# **`battery`**                  | `boolean`          |
# **`engine_operation`**         | `boolean`          |
# **`uniq_form`**                | `boolean`          |
# **`tax_receipt`**              | `boolean`          |
# **`lights`**                   | `boolean`          |
# **`directional_signals`**      | `boolean`          |
# **`external_fog_lights`**      | `boolean`          |
# **`blind`**                    | `boolean`          |
# **`front_bumper`**             | `boolean`          |
# **`hood`**                     | `boolean`          |
# **`wiper_blades`**             | `boolean`          |
# **`front_right_fender`**       | `boolean`          |
# **`front_right_door`**         | `boolean`          |
# **`back_right_door`**          | `boolean`          |
# **`right_stirrup`**            | `boolean`          |
# **`back_right_fender`**        | `boolean`          |
# **`back_bumper`**              | `boolean`          |
# **`trunk_door`**               | `boolean`          |
# **`back_left_fender`**         | `boolean`          |
# **`back_left_door`**           | `boolean`          |
# **`front_left_door`**          | `boolean`          |
# **`left_stirrup`**             | `boolean`          |
# **`canvas_hood`**              | `boolean`          |
# **`top`**                      | `boolean`          |
# **`jack`**                     | `boolean`          |
# **`bolt_wrench`**              | `boolean`          |
# **`tool_kit`**                 | `integer`          |
# **`tool_keys`**                | `integer`          |
# **`front_tires`**              | `boolean`          |
# **`back_tires`**               | `boolean`          |
# **`spare_tires`**              | `boolean`          |
# **`common_rims`**              | `integer`          |
# **`luxury_rims`**              | `integer`          |
# **`cups`**                     | `integer`          |
# **`front_windshield`**         | `boolean`          |
# **`front_right_window`**       | `boolean`          |
# **`rear_right_window`**        | `boolean`          |
# **`third_rear_right_window`**  | `boolean`          |
# **`rear_windshield`**          | `boolean`          |
# **`rear_left_window`**         | `boolean`          |
# **`front_left_window`**        | `boolean`          |
# **`third_rear_left_window`**   | `boolean`          |
# **`air_conditioner`**          | `boolean`          |
# **`electric_windows`**         | `integer`          |
# **`central_block`**            | `integer`          |
# **`sun_roof`**                 | `boolean`          |
# **`luxury_steering_wheel`**    | `boolean`          |
# **`floor_mats`**               | `integer`          |
# **`triangles`**                | `integer`          |
# **`first_aid_kit`**            | `boolean`          |
# **`leather_upholstery`**       | `boolean`          |
# **`pijama`**                   | `boolean`          |
# **`trunk_cover`**              | `boolean`          |
# **`celular_phone`**            | `boolean`          |
# **`electric_antena`**          | `boolean`          |
# **`antena`**                   | `boolean`          |
# **`observations`**             | `text`             |
# **`created_at`**               | `datetime`         | `not null`
# **`updated_at`**               | `datetime`         | `not null`
#
