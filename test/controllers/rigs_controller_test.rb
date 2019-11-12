require 'test_helper'

class RigsControllerTest < ActionController::TestCase
  
  def setup
    @base = "Job Request System"   
    @admin = users(:admin)  
  end

  test "should get new" do
    log_in_as(@admin)
    get :new
    assert_response :success
    assert_template 'rigs/new'
    assert_select "title", "Register RIG | #{@base}" 
    assert_select 'h1', text: 'Register New RIG'
  end

  test "should get index" do
    log_in_as(@admin)
    get :index
    assert_response :success
    assert_template 'rigs/index'
    assert_select "title", "All RIGs | #{@base}" 
    # assert_select 'h1', text: 'All Rig Codes'
  end

end
