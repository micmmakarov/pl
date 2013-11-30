require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :my_video_list
    assert_response :success
  end

end
