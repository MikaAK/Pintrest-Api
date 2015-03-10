require 'pry'
module PintrestApi

  # Pintrest Pin model
  class Pin < Core
    attr_reader :image_url, :title, :credits_url, :url, :description

    PINTREST_URL     = 'http://www.pinterest.com'
    PIN_BASE_CSS     = '.Grid .Pin'
    PIN_IMAGE_CSS    = '.pinHolder .pinImg'
    PIN_TITLE_CSS    = '.richPinGridTitle'
    PIN_CREDIT_CSS   = '.creditItem a'
    PIN_URL_CSS      = '.pinHolder .pinImageWrapper'
    PIN_DESCRIPT_CSS = '.pinDescription'

    def initialize(image_url, title, credits_url, url, description)
      @image_url   = image_url
      @title       = title
      @credits_url = credits_url
      @url         = url
      @description = description
    end

    class << self
      include Authentication
      attr_accessor :is_logged_in
      ##
      # Gets all pins from a board url
      #
      # ==== Attributes
      #
      # * +board_url+ - Pintrest board url
      # * +authentication+ -
      # ==== Examples
      #
      # PintrestApi::Pin.get_for_board_url('http://pintrest.com/mikaak/my-pins', {email: 'asdf@gmail.com', password: 'asdf'})
      def get_for_board_url(board_url, authentication)
        try_or_check_login authentication

        session_visit http_url(board_url)
        parse_pins get_with_ajax_scroll(PIN_BASE_CSS)
      end

      ##
      # Gets all pins from a board url
      #
      # ==== Attributes
      #
      # * +board+ - Pintrest board
      # * +authentication+ -
      # ==== Examples
      #
      # PintrestApi::Pin.get_for_board(board, {email: 'asdf@gmail.com', password: 'asdf'})
      def get_for_board(board, authentication = nil)
        try_or_check_login authentication

        session_visit http_url(board.url)
        parse_pins get_with_ajax_scroll(PIN_BASE_CSS)
      end

      ##
      # Gets all pins from a board url
      #
      # ==== Attributes
      #
      # * +board+ - Pintrest board
      # * +authentication+ -
      # * +&block+ - a stream of every 25ish pins
      # ==== Examples
      #
      # PintrestApi::Pin.get_for_board_stream(board, {email: 'asdf@gmail.com', password: 'asdf'}) do |pins| end
      def get_for_board_stream(board, authentication = nil)
        try_or_check_login authentication

        session_visit http_url(board.url)
        stream_with_ajax_scroll(PIN_BASE_CSS) do |pins|
          yield parse_pins pins
        end
      end

      ## Planned
      # def top(count)
      #   # Raise error if over 800 as page will freeze if higher
      #   raise ArugmentError, 'count must be less than 800' if count > 800
      # end

      private

      def http_url(url)
        url =~ /http/ ? url : "http://#{url}"
      end

      def parse_pins(nokogiri_items)
        pins = []

        nokogiri_items.each do |item|
          pin_image       = attribute_value(item, PIN_IMAGE_CSS, 'src')
          pin_credits     = attribute_value(item, PIN_CREDIT_CSS, 'href')
          pin_credits     = pin_credits && PINTREST_URL + pin_credits
          pin_url         = attribute_value(item, PIN_URL_CSS, 'href')
          pin_url         = pin_url && PINTREST_URL + pin_url
          pin_description = item.css(PIN_DESCRIPT_CSS).inner_text.strip
          pin_title       = item.css('.richPinGridTitle').inner_text.strip


          pins << Pin.new(pin_image, pin_title, pin_credits, pin_url, pin_description)
        end

        pins
      end

      def attribute_value(item, css, attrib)
        item_value = item.css(css)
        item_value.any? && item_value.attribute(attrib).value
      end
    end
  end
end
