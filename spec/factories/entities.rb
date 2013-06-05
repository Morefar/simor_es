
FactoryGirl.define do
  factory :entity do
    address "Avenida Jimenez 5 43 Oficina 1001"
    city "Bogota"
    email "info@morefar.co"
    identification_number "289.988.930-5"
    identification_type { create(:identification_type) }
    mobile_phone "(321) 987-9840"
    name "Pedro Perez Pinto"
    phone "1 705-3403"
    state "Cundinamarca"
  end
end
