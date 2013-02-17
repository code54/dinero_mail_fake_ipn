require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def notification_document(name)
    path = Rails.root.join('test', 'fixtures', 'files', 'notification_documents', "#{name}.xml")
    File.read(path)
  end

  test "one operation notification document" do
    notification = Notification.new(%w[1000])
    assert_equal notification_document(:one_operation), notification.document
  end

  test "several operations notification document" do
    notification = Notification.new(%w[1000 1001 1002])
    assert_equal notification_document(:several_operations), notification.document
  end
end
