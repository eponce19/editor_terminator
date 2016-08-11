require 'html5_validator/validator'

class WelcomeController < ApplicationController

  def index
    @validator = Html5Validator::Validator.new
    @html =
    "
    <!DOCTYPE html>
<html>
<head>
  <h1>asdasd</h1>
  <title>asdasd</title>
</head>
<body>
<h1>hola</h1>
<h23>
</body>
</html>"
    # Passing in an html string directly
    @validator.validate_text(@html)
  end
end
