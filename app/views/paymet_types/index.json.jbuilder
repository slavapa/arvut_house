json.array!(@paymet_types) do |paymet_type|
  json.extract! paymet_type, :name, :frequency
  json.url paymet_type_url(paymet_type, format: :json)
end