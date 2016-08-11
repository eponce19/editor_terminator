class EditorController < ApplicationController
  def index
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
    page = Nokogiri::HTML(@html)
    xml = Nokogiri::XML(@html)
    @errors = Array.new
    #errors
    begin
      xml = Nokogiri::XML(@html) { |config| config.strict }
    rescue Nokogiri::XML::SyntaxError => e
      @errors[0] = "Check if you close your tags"
    end

    if @errors.length < 1
      page.at('body').children.each do |node|
        @xml_name = node.name
        @xml_attributes = node.attributes
      end
    end

    #exist h1
    @h1_exist = page.css('h1').length
    @h1_content = page.css('h1').text == "Hola Mundo" ? 1:0
    @h1_attributes = page.css('h1').attribute('class').value == "col-md-12" ? 1:0

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

end
