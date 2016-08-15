class Html::ValidateSyntax

 include Service

 attr_reader :code
 def initialize(code)
   @code = code
 end

 def call
   #validate is correct the sintaxis
   errors = Array.new

   begin
     xml = Nokogiri::XML(@code) { |config| config.strict }

     #validate if html follow w3, uncomment when check all the page
       #"<!DOCTYPE html>
       # <html>
       #   <head>
       #     <h1>asdasd</h1>
       #     <title>asdasd</title>
       #   </head>
       #   <body>
       #     <h1>hola</h1>
       #   </body>
       # </html>"
     # @validator = Html5Validator::Validator.new
     # @validator.validate_text(@html)

   rescue Nokogiri::XML::SyntaxError => e
     errors[0] = "Check if you close your tags"
   end

   errors
 end

end
