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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory do
    inspection { create(:inspection) }
    kilometers true
    villare true
    glove_compartment true
    dashboard true
    right_seat true
    left_seat true
    back_seat true
    third_row true
    courtesy_light true
    seat_belt true
    radio_brand 'Pioneer'
    cd_player true
    speakers 4
    lighter true
    ash_trays 2
    clock true
    door_panels 4
    rearview_mirrors 1
    head_rest 2
    handles true
    horn true
    side_mirrors 2
    warranty_book true
    driver_manual true
    ignition true
    battery true
    engine_operation true
    uniq_form true
    tax_receipt true
    lights true
    directional_signals true
    external_fog_lights true
    blind true
    front_bumper true
    hood true
    wiper_blades true
    front_right_fender true
    front_right_door true
    back_right_door true
    right_stirrup true
    back_right_fender true
    back_bumper true
    trunk_door true
    back_left_fender true
    back_left_door true
    front_left_door true
    left_stirrup true
    canvas_hood true
    top true
    jack true
    bolt_wrench true
    tool_kit 1
    tool_keys 5
    front_tires true
    back_tires true
    spare_tires true
    common_rims 2
    luxury_rims 2
    cups 4
    front_windshield true
    front_right_window true
    rear_right_window true
    third_rear_right_window true
    rear_windshield true
    rear_left_window true
    front_left_window true
    third_rear_left_window true
    air_conditioner true
    electric_windows 2
    central_block 2
    sun_roof true
    luxury_steering_wheel true
    floor_mats 3
    triangles 2
    first_aid_kit true
    leather_upholstery true
    pijama true
    trunk_cover true
    celular_phone true
    electric_antena true
    antena true
    observations 'Car in perfect conditions'
  end
end
