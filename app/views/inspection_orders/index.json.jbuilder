json.array!(@inspection_orders) do |inspection_order|
  json.extract! inspection_order, :id
  json.url inspection_order_url(inspection_order, format: :json)
end
