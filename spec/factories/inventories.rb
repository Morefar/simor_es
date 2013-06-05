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
