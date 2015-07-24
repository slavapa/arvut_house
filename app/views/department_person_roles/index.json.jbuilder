json.array!(@department_person_roles) do |department_person_role|
  json.extract! department_person_role, :department_id, :person_id, :role_id
  json.url department_person_role_url(department_person_role, format: :json)
end