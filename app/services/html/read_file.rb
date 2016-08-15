class Html::ReadFile
 include Service

 attr_reader :exercise
 def initialize(exercise)
   @exercise = exercise
 end

 def call
   fileHtml = File.open("exercises/" + @exercise + ".html", "r")
   text = ""
   begin
     fileHtml.each_line do |line|
       text << line
     end
     fileHtml.close
   rescue
     text = "error"
   ensure
     #fileHtml.close unless fileHtml.nil?
   end
   #return html in text
   text
 end

end
