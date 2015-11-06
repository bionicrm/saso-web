require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    
    # TODO: fix?
    assert_response 302
  end

end
