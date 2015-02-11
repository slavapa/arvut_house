json.array!(@payments) do |payment|
  json.extract! payment, :description, :payment_date, :payment_type_id
  json.url payment_url(payment, format: :json)
end