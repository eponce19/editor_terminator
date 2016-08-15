class Html::Match

 include Service

 attr_reader :code
 def initialize(code, exercise)
   @code = code
   @exercise = exercise
 end

 def call
   #Match if the code have the same elements than the exercise
   html_errors = Array.new
   file = "exercises/" + @exercise + ".html"
   code = Nokogiri::HTML(@code)

   elements = Html::GetElements.call(file)
   #@elements = Html::PrintElements.call(elements)

   elements.each do |element|
     if element.name == "text"
       #code if element is text
     else

       if code.css(element.name).length == 0
         html_errors << element.name + " not exist"
       else

       element.attribute_nodes.each do |element_attribute|
         if !code.css(element.name).attribute(element_attribute.name).nil?
           if code.css(element.name).attribute(element_attribute.name).value != element_attribute.value
             html_errors << element_attribute.name + " not is the same value " + element_attribute.value
           end
         else
           html_errors << element_attribute.name + " not exist"
         end

       end

     end

   end


 end
  html_errors
 end

end
