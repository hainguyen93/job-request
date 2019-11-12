require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @cmt = Comment.new(user_id: 1, job_id: 1, content: "something")
  end

  test "user_id should be present" do
    @cmt.user_id = nil
    assert_not @cmt.valid?
  end

  test "job_id should be present" do
    @cmt.job_id = nil
    assert_not @cmt.valid?
  end 
end
