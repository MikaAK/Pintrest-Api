module PintrestApi
  # Pintrest Boards this is used to fetch boards and related pins
  class Board < Core
    attr_reader :title, :board_url

    PINTREST_URL = 'http://www.pintrest.com/'

    def initialize(title, board_url)
      @title = title
      @board_url = board_url
    end

    class << self
      def all(user_name)
        visit_page user_name
        parse_boards get_with_ajax_scroll('.GridItems > .item')
      end

      def pins(user_name, board_name)
        board_slug = board_name.downcase.gsub(/_ /, '-').gsub(/[^a-zA-Z0-9]/, '')
        Pin.get_for_board_url("#{PINTREST_URL}#{user_name}/#{board_slug}")
      end

      private

      def parse_boards(nokogiri_items)
        items = []

        nokogiri_items.each do |item|
          board_title = item.css('h3.boardName .title').inner_text
          board_link = PINTREST_URL.chomp('/') + item.css('.boardLinkWrapper').attribute('href').value

          items << Board.new(board_title, board_link)
        end

        items
      end
    end
  end
end
