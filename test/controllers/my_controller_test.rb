require 'test_helper'

class MyControllerTest < ActionDispatch::IntegrationTest
  test "should get payme" do
    get my_payme_url
    assert_response :success
  end

end
