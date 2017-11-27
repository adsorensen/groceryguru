require 'test_helper'

class SavedRecipesControllerTest < ActionController::TestCase
  setup do
    @saved_recipe = saved_recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saved_recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saved_recipe" do
    assert_difference('SavedRecipe.count') do
      post :create, saved_recipe: { personal: @saved_recipe.personal }
    end

    assert_redirected_to saved_recipe_path(assigns(:saved_recipe))
  end

  test "should show saved_recipe" do
    get :show, id: @saved_recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saved_recipe
    assert_response :success
  end

  test "should update saved_recipe" do
    patch :update, id: @saved_recipe, saved_recipe: { personal: @saved_recipe.personal }
    assert_redirected_to saved_recipe_path(assigns(:saved_recipe))
  end

  test "should destroy saved_recipe" do
    assert_difference('SavedRecipe.count', -1) do
      delete :destroy, id: @saved_recipe
    end

    assert_redirected_to saved_recipes_path
  end
end
