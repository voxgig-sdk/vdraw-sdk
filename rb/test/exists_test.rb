# Vdraw SDK exists test

require "minitest/autorun"
require_relative "../Vdraw_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = VdrawSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
