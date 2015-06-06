json.array!(@goods) do |good|
  json.extract! good, :id
  json.url good_url(good, format: :json)
end
