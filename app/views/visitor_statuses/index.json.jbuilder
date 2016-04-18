json.array!(@visitor_statuses) do |visitor_status|
  json.extract! visitor_status, :name
  json.url visitor_status_url(visitor_status, format: :json)
end