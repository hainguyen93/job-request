require 'test_helper'

class AdminViewsAllRigsTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin) 
    @rig = rigs(:rig1)     
  end


  # admin can view all rig codes
  test "admin can views all rigs" do
    log_in_as(@admin)
    get rigs_path
    assert_template 'rigs/index'
    #assert_select 'h1', text: 'All Rig Codes'    
  end  
  
end
