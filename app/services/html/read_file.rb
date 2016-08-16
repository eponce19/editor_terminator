class Html::ReadFile
 include Service

 attr_reader :exercise
 def initialize(source)
   @source = source
 end

 def call
   fileHtml = File.open(@source, "r")
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
