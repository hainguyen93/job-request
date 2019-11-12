require 'test_helper'

class JobTest < ActiveSupport::TestCase

  def setup
    @job = Job.new(title: "new job", 
                   rig_id: 10,
                   description: "a short description", 
                   deadline: '2015-06-20 12:00:00')

    @admin = users(:admin)
  end

  test "should be valid" do
    assert @job.valid?
  end

  #test title attribute
  test "title should be present" do
    @job.title = " "
    assert_not @job.valid?
  end

  #test rig_id attribute
  test "rig code should be chosen" do
    @job.rig_id = 5
    assert @job.valid?
  end

  # test description
  test "description should be present" do
    @job.description = " "
    assert_not @job.valid?
  end

  #test deadline attribute
  test "deadline should not be in the past" do
    @job.deadline = '2014-01-01 00:00:00'
    assert_not @job.valid?
  end

  test "deadline should be in the future" do
    @job.deadline = Date.today + 1.day
    assert @job.valid?
  end

  # associated cmts should be destroyed when job gets destroyed
  test "associated comments should be destroyed" do
    @job.save
    @job.comments.create(user_id: @admin.id,
                         content: "something" )
    assert_difference 'Comment.count', -1 do
      @job.destroy
    end    
  end  
end
