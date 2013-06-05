FactoryGirl.define do
  factory :inspection do
    asset {create(:asset)}
    inspection_number 'V129'
    address 'Carrera 1 # 2 - 3'
    city 'Chicago'
    state 'Ilinois'
    date Time.now
    current_value 10500000
    appraiser_value 10000000
    soat_number 'AB98934'
    soat_begin_date '2012-05-29'
    soat_finish_date '2013-05-29'
    gas_certificate '98798409882'
    gas_begin_date '2010-02-21'
    gas_finish_date '2012-02-21'
    maintenance 'Yada yada yada yada'
    repairs 'Yada yada yada yada'
    security 'Yada yada yada yada'
    exterior 'Yada yada yada yada'
    interior 'Yada yada yada yada'
    engine 'Yada yada yada yada'
    accesories 'Yada yada yada yada'
    insurance_number '123UNOI98'
    insurance_company 'ING'
    insured_value 15000000
    currency 'COP'
    insurance_start '2013-05-24'
    insurance_finish '2014-05-24'
    person_in_charge 'Tomas de Aquino'
    pic_id '38.766.298'
    pic_job 'Security guard'
  end
end
