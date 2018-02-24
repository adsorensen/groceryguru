require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get done" do
    get :done
    assert_response :success
  end

end
