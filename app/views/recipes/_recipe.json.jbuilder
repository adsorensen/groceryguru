json.extract! recipe, :id, :name, :description, :ingredients, :instructions, :note, :tags, :origin, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
