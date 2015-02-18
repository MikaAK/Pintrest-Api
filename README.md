Pintrest Api
===

An api in ruby for pulling pintrest pins. It is not very fast due to the fact
that you must use capybara to parse the page.

### Warning
Certain issues require you to login first (getting more then 50 pins per board)
To do this when calling anything to do with pins you can pass in
`email: <email>, password: <password>` as a last parameter.
