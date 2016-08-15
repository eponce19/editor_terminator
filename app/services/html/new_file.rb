class Html::NewFile
 include Service

 attr_reader :exercise, :code
 def initialize(code,exercise)
   @code = code
   @exercise = exercise
 end

 def call
   fileHtml = File.new("exercises/" + @exercise + ".html", "w+")
   result = true
   begin
     fileHtml.puts @code
   rescue
     result = false
   ensure
     fileHtml.close unless fileHtml.nil?
   end
   #return true if file was succesfully created
   result
 end

end
