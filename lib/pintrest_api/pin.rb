module PintrestApi
  # Pintrest Pin model
  class Pin < Core
    attr_reader :image_url, :title, :credits_url, :url, :description

    PIN_BASE_CSS = '.Pin'

    class << self
      include Authentication
      ##
      # Gets all pins from a board url
      #
      # ==== Attributes
      #
      # * +board_url+ - Pintrest board url
      # ==== Examples
      #
      # PintrestApi::Pin.get_for_board_url('http://pintrest.com/mikaak/my-pins')
      def get_for_board_url(board_url, authentication)
        login(authentication) if authentication
        @session.visit board_url
        @session.save_and_open_page
        parse_pins get_with_ajax_scroll(PIN_BASE_CSS)
      end

      def get_for_board(board, authentication)
        login(authentication) if authentication

        parse_pins get_with_ajax_scroll(PIN_BASE_CSS)
      end

      ## Planned
      # def top(count)
      #   # Raise error if over 800 as page will freeze if higher
      #   raise ArugmentError, 'count must be less than 800' if count > 800
      # end

      private

      def parse_pins(nokogiri_items)
        binding.pry
      end
    end
  end
end
