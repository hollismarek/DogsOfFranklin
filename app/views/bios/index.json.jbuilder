json.array!(@bios) do |bio|
  json.extract! bio, :id, :name, :age, :breed, :likes, :fears, :details
  json.url bio_url(bio, format: :json)
end
