json.array!(@details) do |detail|
  json.extract! detail, :id
  json.url detail_url(detail, format: :json)
end
