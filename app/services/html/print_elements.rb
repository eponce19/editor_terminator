class Html::PrintElements
 include Service

 attr_reader :code
 def initialize(code)
   @code = code
 end

 def call
   text = ""
   @code.each do |child|
     text << "name = " + child.name + "<br>"
     text << "content = " + child.text + "<br>" if child.text?
     child.attribute_nodes.each do |child_attribute|
        text << child.name + " attribute = " + child_attribute.name + " - " + child_attribute.value + "<br>"
     end
     text << "<hr>"
   end
   text
 end

end
