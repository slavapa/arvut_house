json.array!(@people) do |person|
  json.extract! person, :name, :email, :password_digest, :remember_token
  json.url person_url(person, format: :json)
end