require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'pry'


module PintrestApi
  ##
  # This class is the core of the pintrest api and handles all url visiting and such
  class Core
    attr_accessor :session
    include Capybara::DSL

    PINTREST_URL = 'http://www.pinterest.com/'

    class << self
      def visit_page(user_name)
        new_session
        @session.visit PINTREST_URL + user_name
        sleep 5
        @session
      end

      def session_visit(url)
        url = PINTREST_URL + url if url !~ /pinterest/

        begin
          @session.visit url
          sleep 3
        rescue Capybara::Poltergeist::TimeoutError
          puts 'Gotten blocked by pintrest waiting 2 min to try again'
          sleep 120

          session_visit url
        end
      end

      def visit(url)
        new_session
        @session.visit url
        sleep 5
        @session
      end

      def click(css)
        @session.find(css).click
      end

      # Create a new PhantomJS session in Capybara
      def new_session
        # Register PhantomJS (aka poltergeist) as the driver to use
        Capybara.register_driver :poltergeist do |app|
          Capybara::Poltergeist::Driver.new(app, timeout: 60, js_errors: false)
        end

        # Use CSS as the default selector for the find method
        Capybara.default_selector = :css

        # Start up a new thread
        @session = Capybara::Session.new(:poltergeist)

        # Report using a particular user agent
        @session.driver.headers = { 'User-Agent' =>
          "Mozilla/5.0 (Macintosh; Intel Mac OS X)" }

        # Return the driver's session
        @session
      end

      def scroll_page
        @session.execute_script 'window.scrollTo(0,100000)'
        sleep 2
      end

      # Returns the current session's page
      def html
        @session.body
      end

      def get_with_ajax_scroll(css_selector)
        old_items_count = 0
        items = []



        until (items.count === old_items_count) && items.count > 0
          old_items_count = items.count
          scroll_page if old_items_count > 0

          new_items = Nokogiri::HTML.parse(html).css css_selector
          items = new_items if old_items_count === 0 || new_items.count > old_items_count
          puts "New Count: #{items.count}\nOld Count: #{old_items_count}"
        end

        items
      end

      def stream_with_ajax_scroll(css_selector)
        old_items_count = 0
        items = []

        until (items.count === old_items_count) && items.count > 0
          old_items_count = items.count
          scroll_page if old_items_count > 0

          items = Nokogiri::HTML.parse(html).css css_selector if old_items_count === 0 || items.count > old_items_count

          yield items[old_items_count..-1] if items.count > old_items_count

          puts "New Count: #{items.count}\nOld Count: #{old_items_count}"
        end

        items
      end
    end
  end
end
