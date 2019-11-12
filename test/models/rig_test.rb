require 'test_helper'

class RigTest < ActiveSupport::TestCase
  
  def setup
    @rig = Rig.new(code: "112 ABC")
  end

  test "rig code should be present" do
    @rig.code = " "
    assert_not @rig.valid?
  end

  #test "should follow pre-defined format" do
  #  invalid_codes = ['abc', '123', 'abc 123']
  #  invalid_codes.each do |invalid_code|
  #    @rig.code = invalid_code
  #    assert_not @rig.valid?, "#{invalid_code.inspect} should be invalid"
  #  end
  #end
end
