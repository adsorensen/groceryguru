# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( recipe.js )
Rails.application.config.assets.precompile += %w( styles.css )
Rails.application.config.assets.precompile += %w( welcome.css )
Rails.application.config.assets.precompile += %w( recipes.css )
Rails.application.config.assets.precompile += %w( user_login.css )
Rails.application.config.assets.precompile += %w( recipes_tab.css )
Rails.application.config.assets.precompile += %w( new_recipes.css )
Rails.application.config.assets.precompile += %w( cart.css )
Rails.application.config.assets.precompile += %w( users.css )
Rails.application.config.assets.precompile += %w( users_new.css )
Rails.application.config.assets.precompile += %w( users_show.css )
Rails.application.config.assets.precompile += %w( users_edit.css )
Rails.application.config.assets.precompile += %w( edit_users.js )
Rails.application.config.assets.precompile += %w( list.css )
Rails.application.config.assets.precompile += %w( calendar.css )
Rails.application.config.assets.precompile += %w( calendar_print.css )
Rails.application.config.assets.precompile += %w( calendar.js )
Rails.application.config.assets.precompile += %w( newRecipe.js )
Rails.application.config.assets.precompile += %w( recipe_search_results.css )
Rails.application.config.assets.precompile += %w( new_age/new_age.css )
Rails.application.config.assets.precompile += %w( new_age/manifest.js new_age/manifest.css )
Rails.application.config.assets.precompile += %w( carousel.css )
Rails.application.config.assets.precompile += %w( multi-select.css )
Rails.application.config.assets.precompile += %w( jquery.multi-select.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )