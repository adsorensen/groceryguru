json.extract! recipe, :id, :name, :instructions, :directions, :description, :origin, :created_at, :updated_at, :picture
json.url recipe_url(recipe, format: :json)
