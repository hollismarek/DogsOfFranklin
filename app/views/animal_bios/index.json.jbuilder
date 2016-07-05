json.array!(@animal_bios) do |animal_bio|
  json.extract! animal_bio, :id, :name, :age, :breed, :likes, :fears, :details
  json.url animal_bio_url(animal_bio, format: :json)
end
