json.array!(@pin_properties) do |pin|
  json.extract! pin, :id, :name, :description, :picture
  json.url pinboard_url(idea, format: :json)
end
