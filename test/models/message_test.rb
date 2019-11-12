require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  def setup
    @msg = Message.new(name: "visitor", 
                       email: "visitor@gmail.com", 
                       content: "something")
  end

  # test visitor's name
  test "name should be present" do
    @msg.name = " "
    assert_not @msg.valid?
  end

  test "name should not be too long" do
    @msg.name = "a"*200
    assert_not @msg.valid?
  end

  # test visitor's email
  test "email should be present" do
    @msg.email = " "
    assert_not @msg.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com 
                           user_at_foo.org 
                           user.name@example.
                           foo@bar_baz.com 
                           foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @msg.email = invalid_address
      assert_not @msg.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should not be too long" do
    @msg.email = "a"*254 + "@gmail.com"
    assert_not @msg.valid?
  end

  # test visitor's message
  test "content should be present" do
    @msg.content = " "
    assert_not @msg.valid?
  end

end
