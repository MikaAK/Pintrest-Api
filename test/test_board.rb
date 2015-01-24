require 'pry'
require_relative './spec_helper.rb'

class TestBoard  < Minitest::Test
  include SpecHelper

  def test_all_gets_all_boards
    @session.visit 'http://www.pinterest.com/' + PIN_USER
    sleep 3
    expected_board_count = Nokogiri::HTML.parse(@session.body).css('.BoardCount > .value').inner_text.to_i
    actual_board_count = PintrestApi::Board.all(PIN_USER).count

    assert_equal expected_board_count, actual_board_count
  end

  def test_pins_get_users_pins_for_board
    @session.visit 'http://www.pintrest.com/' + PIN_USER
    sleep 3
    doc = Nokogiri::HTML.parse @session.body
    board_name = doc.css('.boardName').inner_text
    binding.pry
    expected_pin_count = doc.css('.PinCount > .value').inner_text
    actual_pin_count = PintrestApi::Board.pins(PIN_USER, board_name)

    assert_equal expected_board_count, actual_pin_count
  end
end
