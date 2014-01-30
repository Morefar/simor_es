json.extract! @inspection_order, :id, :asset, :status, :recurring, :created_at, :updated_at
  if @inspection_order.recurring?
    json.renew_period @inspection_order.renew_period
  end
