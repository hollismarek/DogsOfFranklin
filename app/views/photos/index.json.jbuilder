json.array!(@images) do |image|
  json.extract! image, :id, :path, :comment
  json.url image_url(image, format: :json)
end
