module PintrestApi
  # Pintrest Boards this is used to fetch boards and related pins
  module Authentication
    EMAIL_INPUT_CSS       = '.loginUsername input'
    PASSWORD_INPUT_CSS    = '.loginPassword input'
    LOGIN_PAGE_BUTTON_CSS = '.formFooter .formFooterButtons'
    PINTREST_LOGIN_URL    = 'https://www.pinterest.com/login/'

    def login(authentication)
      visit PINTREST_LOGIN_URL

      @session.find(EMAIL_INPUT_CSS).set authentication[:email]
      @session.find(PASSWORD_INPUT_CSS).set authentication[:password]
      click LOGIN_PAGE_BUTTON_CSS

      sleep 5
      puts 'Finished logging in'
    end
  end
end
