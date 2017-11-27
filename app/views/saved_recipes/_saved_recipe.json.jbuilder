json.extract! saved_recipe, :id, :personal, :created_at, :updated_at
json.url saved_recipe_url(saved_recipe, format: :json)
