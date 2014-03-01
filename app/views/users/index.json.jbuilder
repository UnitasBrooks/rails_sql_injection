json.array!(@users) do |user|
  json.extract! user, :id, :name, :phone_number, :ssn
  json.url user_url(user, format: :json)
end
