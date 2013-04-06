
require "minitest/autorun"
require_relative '../lib/alcatel/call_server'

class TestCallServer < MiniTest::Unit::TestCase

  def setup
    @obj = Alcatel::CallServer.new 'atmss990'
  end
   
  def test_mss_name
    assert_equal "ATMSS990", @obj.mss_name
  end
   
  def test_emsdigitdescriptor
    assert @obj.respond_to? :emsdigitdescriptor
  end
   
  def teardown
    @obj = nil
  end
end

