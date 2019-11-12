require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @base = "Job Request System"
  end
 
  # test 'about' page
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base}"   
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", 'http://www.shef.ac.uk', text: 'The University of Sheffield'
    assert_select 'p.text-justify', count: 4
  end

  # 'contact' page
  test "should get contact" do
    get :contact
    assert_response :success
    assert_template 'static_pages/contact'
    assert_select "title", "Contact | #{@base}"
    assert_select 'div.row', count: 1
    #assert_select 'div.col-md-offset-3', count: 1
  end  
  
end
