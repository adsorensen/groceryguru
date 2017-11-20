require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get loadcart" do
    get :loadcart
    assert_response :success
  end

end
