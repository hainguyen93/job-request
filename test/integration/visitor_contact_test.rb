require 'test_helper'

class VisitorContactTest < ActionDispatch::IntegrationTest

  test "valid contact message" do
    get contact_path
    assert_response :success
    assert_template 'static_pages/contact'
    post_via_redirect contact_path, message: { name: "visitor",
                                               email: "visitor@gmail.com",
                                               content: "something" }
    assert_template 'static_pages/contact'
    assert_not flash.empty?
  end

  test "invalid contact message" do 
    get contact_path
    assert_response :success
    post contact_path, message: { name: " ",
                                  email: "visitor@gmail.com",
                                  content: "something" }
    assert_template 'static_pages/contact'
    assert flash.empty?
  end

end
