json.array!(@links) do |link|
  json.extract! link, :id, :url, :name, :description
  json.url link_url(link, format: :json)
end
