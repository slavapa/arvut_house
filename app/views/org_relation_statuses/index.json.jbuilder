json.array!(@org_relation_statuses) do |org_relation_status|
  json.extract! org_relation_status, :name
  json.url org_relation_status_url(org_relation_status, format: :json)
end