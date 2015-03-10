module PintrestApi
  # Pintrest Boards this is used to fetch boards and related pins
  class Board < Core
    attr_reader :title, :url, :pin_count

    PINTREST_URL = 'http://www.pinterest.com/'
    BOARD_PIN_COUNT_CSS = '.PinCount'
    BOARD_LINK_CSS      = '.boardLinkWrapper'
    BOARD_TITLE_CSS     = 'h3.boardName .title'
    BOARD_ITEM_CSS      = '.UserBoards .item'

    ##
    # Get a instance of a board
    #
    # ==== Attributes
    #
    # * +title+ - Pintrest board title
    # * +board_url+ - Pintrest board url
    # * +pin_count+ - Pintrest boards pin count
    # ==== Examples
    #
    # PintrestApi::Board.new('Yummy Pins', 'http://pintrest.com/mikaak/yummy-pins', 38)
    def initialize(title, board_url, pin_count)
      @title = title
      @url = board_url
      @pin_count = pin_count
    end

    def pins
      Pin.get_for_board(self)
    end

    class << self
      include Authentication
      ##
      # Gets all boards from a user
      #
      # ==== Attributes
      #
      # * +user_name+ - Pintrest username
      # ==== Examples
      #
      # PintrestApi::Board.all('mikakalathil')
      def all(user_name, authentication)
        try_or_check_login authentication

        session_visit user_name
        @session.save_and_open_page

        parse_boards get_with_ajax_scroll(BOARD_ITEM_CSS)
      end

      ##
      # Gets all pins from a specific board
      #
      # ==== Attributes
      #
      # * +user_name+ - Pintrest username
      # * +board_name+ - Pintrest board_name
      # ==== Examples
      #
      # PintrestApi::Board.pins('mikakalathil', 'My Board Name!!!', {email: 'asdf@gmail.com', password: 'asdf'})
      def pins(user_name, board_name, authentication)
        try_or_check_login authentication

        board_slug = board_name.downcase.gsub(/[_\s]/, '-')
        Pin.get_for_board_url("#{user_name}/#{board_slug}", authentication)
      end

      private

      def parse_boards(nokogiri_items)
        items = []

        nokogiri_items.each do |item|
          board_title = item.css(BOARD_TITLE_CSS).inner_text
          board_link  = PINTREST_URL.chomp('/') + item.css(BOARD_LINK_CSS).attribute('href').value
          pin_count   = item.css(BOARD_PIN_COUNT_CSS).inner_text.strip

          items << Board.new(board_title, board_link, pin_count)
        end

        items
      end
    end
  end
end
