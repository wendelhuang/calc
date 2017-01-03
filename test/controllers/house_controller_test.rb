require 'test_helper'

class HouseControllerTest < ActionDispatch::IntegrationTest
  test "should get mortgage" do
    get house_mortgage_url
    assert_response :success
  end

end
