class EditorController < ApplicationController
  def index
    exercise = "new"
    @instructions = read_html_file(exercise)
    #code
  end

  def check
    @html = params["editor"]

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

    #validate is correct the exercise
    code = Nokogiri::HTML(@html)
    #xml = Nokogiri::XML(@html)
    @errors = Array.new
    #errors
    begin
      xml = Nokogiri::XML(@html) { |config| config.strict }
    rescue Nokogiri::XML::SyntaxError => e
      @errors[0] = "Check if you close your tags"
    end

    if @errors.length < 1
      code.at('body').children.each do |node|
        @xml_name = node.name
        @xml_attributes = node.attributes
      end
    end

    name = "new"
    exercise = "exercises/"+name+".html"
    elements = get_elements(exercise)
    @elements = print_elements(elements)
    #exist h1
    @html_errors = Array.new

    elements.each do |element|

      if element.name == "text"
        #@html_errors << element.name + " not exist" if code.at(text.value).text.strip.empty?
         #@html_errors << element.name + " is not the same" if code.css("text").text == element.value
      else
        if code.css(element.name).length == 0
          @html_errors << element.name + " not exist"
        else
        element.attribute_nodes.each do |element_attribute|
          if !code.css(element.name).attribute(element_attribute.name).nil?
            if code.css(element.name).attribute(element_attribute.name).value != element_attribute.value
              @html_errors << element_attribute.name + " not is the same value " + element_attribute.value
            end
          else
            @html_errors << element_attribute.name + " not exist"
          end
        end
        end
      end
    end
  end

  def exist_element(element)
    #return page.css(element.name).length > 0
  end

  def same_element(element)
    #return page.css(element.name).text == element.value
  end

  def attribute_element(element, attribute)
    #return page.css(element.name).attribute(attribute.name).value == attribute.value
  end

  def read
    #code
  end

  def show

  end

  def upload
    @html = params["editor"]
    #validate is correct the exercise
    xml = Nokogiri::XML(@html)
    @errors = xml.errors
    @errors = Array.new
    #errors
    begin
      xml = Nokogiri::XML(@html) { |config| config.strict }
    rescue Nokogiri::XML::SyntaxError => e
      @errors[0] = "Check your syntaxis"
    end

    create_html_file(@html,"new")

    @@tags = Array.new
    reader = Nokogiri::HTML(@html)
    reader = remove_empty_text(reader)

    if @errors.length < 1
      reader.at('body').children.each do |child|
        @@tags.push(child)
        add_children(child) if child.children.any?
      end
      p @@tags
      @text = print_elements(@@tags)
    else
      puts "Check your code, some errors appear"
    end
  end

  def get_elements(source)
    @@tags = Array.new
    reader = Nokogiri::HTML(File.open(source))
    reader = remove_empty_text(reader)
    reader.at('body').children.each do |child|
      @@tags.push(child)
      add_children(child) if child.children.any?
    end
    @@tags
  end

  def add_children(parent)
    parent.children.each do |child|
      @@tags.push(child)
      add_children(child) if child.children.any?
    end
  end

  def check_children(parent)
    parent.children.each do |child|
      if child.text?
        child.remove if child.content.to_s.squish.empty?
      end
      check_children(child) if child.children.any?
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

  def print_elements(reader)
    text = ""
    reader.each do |child|
      text << "name = " + child.name + "<br>"
      text << "content = " + child.text + "<br>" if child.text?
      child.attribute_nodes.each do |child_attribute|
         text << child.name + " attribute = " + child_attribute.name + " - " + child_attribute.value + "<br>"
      end
      text << "<hr>"
    end
    text
  end

  def create_html_file(html,name)
    fileHtml = File.new("exercises/"+name+".html", "w+")
    result = true
    begin
      fileHtml.puts html
    p "File created"
    rescue
      result = false
    ensure
      fileHtml.close unless fileHtml.nil?
    end
    return result
  end

  def read_html_file(name)
    fileHtml = File.open("exercises/"+name+".html", "r")
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
    return text
  end

end
