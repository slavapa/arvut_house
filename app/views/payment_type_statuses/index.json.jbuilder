json.array!(@payment_type_statuses) do |payment_type_status|
  json.extract! payment_type_status, :payment_type_id, :status_id
  json.url payment_type_status_url(payment_type_status, format: :json)
end