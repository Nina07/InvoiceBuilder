json.array!(@orders) do |order|
  json.extract! order, :id, :order_no, :order_date, :customer_name
  json.url order_url(order, format: :json)
end
