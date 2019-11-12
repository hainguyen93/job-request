require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase

  def setup
    @msg = Message.new(name: "visitor", 
                       email: "visitor@gmail.com", 
                       content: "something")
  end
  
  # valid visitor's message
  test "visitor email" do
    mail = MessageMailer.contact_message(@msg)
    assert_equal "Visitor Message", mail.subject
    # assert_equal ["t.haycock@sheffield.ac.uk"], mail.to
    assert_equal ["noreply.jobrequestsystem@gmail.com"], mail.from
    assert_match @msg.name, mail.body.encoded
    assert_match @msg.email, mail.body.encoded
    assert_match @msg.content, mail.body.encoded    
  end

  
end
