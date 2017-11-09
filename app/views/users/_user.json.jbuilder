json.extract! user, :id, :id, :password, :admin, :username, :first_name, :last_name, :email, :gluten_free, :lactose_intol, :organic, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
