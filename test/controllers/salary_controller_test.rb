require 'test_helper'

class SalaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get salary_index_url
    assert_response :success
  end

end
