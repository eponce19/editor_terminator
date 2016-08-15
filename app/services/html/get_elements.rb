class Html::GetElements
 include Service

 attr_reader :source
 def initialize(source)
   @source = source
   @tags = Array.new
 end

 def call
   reader = Nokogiri::HTML(File.open(@source))
   reader = remove_empty_text(reader)
   reader.at('body').children.each do |child|
     @tags.push(child)
     add_children(child) if child.children.any?
   end
   @tags
 end

def add_children(parent)
  parent.children.each do |child|
    @tags.push(child)
    add_children(child) if child.children.any?
  end
end

def remove_empty_text (reader)
  reader.at("body").children.each do |child|
    if child.text?
      child.remove if child.content.to_s.squish.empty?
    end
     check_children(child) if child.children.any?
  end
  reader
end

def check_children(parent)
  parent.children.each do |child|
    if child.text?
      child.remove if child.content.to_s.squish.empty?
    end
    check_children(child) if child.children.any?
  end
end

end
