require 'test_helper'

class AcceptorTest < ActiveSupport::TestCase
  
  def setup
    @acceptor = Acceptor.new(user_id: 1, job_id: 1)
  end

  test "user_id should be present" do
    @acceptor.user_id = nil
    assert_not @acceptor.valid?
  end

  test "job_id should be present" do
    @acceptor.job_id = nil
    assert_not @acceptor.valid?
  end
end
