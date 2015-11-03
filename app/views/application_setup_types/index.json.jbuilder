json.array!(@application_setup_types) do |application_setup_type|
  json.extract! application_setup_type, :code_id, :name, :description
  json.url application_setup_type_url(application_setup_type, format: :json)
end