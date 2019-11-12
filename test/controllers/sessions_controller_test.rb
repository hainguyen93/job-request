require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    @base = "Job Request System"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Home | #{@base}" 
    assert_select 'h1', text: 'Welcome'
  end

end
