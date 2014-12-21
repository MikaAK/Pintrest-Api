module PintrestApi
  # Pintrest Pin model
  class Pin < Core
    attr_reader :image_url, :title, :credits_url, :url, :description

    class << self
      ##
      # Gets all pins from a board url
      #
      # ==== Attributes
      #
      # * +board_url+ - Pintrest board url
      # ==== Examples
      #
      # PintrestApi::Pin.get_for_board_url('http://pintrest.com/mikaak/my-pins')
      def get_for_board_url(board_url)
        visit board_url
        increment_page_till_bottom
        # parse_pins get_with_ajax_scroll('.pinImg')
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
