json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :submitter, :url
  json.url recipe_url(recipe, format: :json)
end
