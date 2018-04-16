json.extract! recipe, :id, :name, :instructions, :directions, :calories, :fat, :saturated_fat, :carbs, :cholestrol, :sugar, :sodium, :protein, :description, :origin, :created_at, :updated_at, :picture
json.url recipe_url(recipe, format: :json)
