require 'test_helper'

class TransitionTest < ActiveSupport::TestCase
  test "the truth" do
    transition = Transition.new
    transition.save!
    assert_not_nil transition.scheduled_at
    puts transition.scheduled_at
  end
end
