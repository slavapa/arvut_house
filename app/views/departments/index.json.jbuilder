json.array!(@departments) do |department|
  json.extract! department, :name, :description
  json.url department_url(department, format: :json)
end