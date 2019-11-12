require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # set up the test
  def setup
    @user = User.new(username: "username", name: "user", email: "user@gmail.com",
                     password: "mypassowrd", password_confirmation: "mypassword")
  end

  #test username attribute
  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?    
  end

  test "username should not be too long" do
    @user.username = "a"*100
    assert_not @user.valid?
  end
  
  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "username is unique, ignoring case-sensitive" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.username.upcase
    assert_not duplicate_user.valid?
  end

  #test name attribute
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  # test email attribute
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*50 + "@gmail.com"
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com 
                           user_at_foo.org 
                           user.name@example.
                           foo@bar_baz.com 
                           foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique, ignoring case-sensitive" do
    duplicate_user = @user.dup
    duplicate_user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # test password attribute
  test "password should be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end
 
  test "password should not be too short" do
    @user.password = @user.password_confirmation = "a"*4
    assert_not @user.valid?
  end

end





































