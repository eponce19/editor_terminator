class EditorController < ApplicationController
  def index
    #change exercise name
    exercise = "new"
    @instructions = Html::ReadFile.call(exercise)
  end

  def check
    @html = params["editor"]
    @html_errors = Array.new
    result = Array.new

    #validate syntasis
    @errors = Html::ValidateSyntax.call(@html)
    result << @errors[0]

    #change name of exercise
    exercise = "new"

    if @errors.empty?
      result = Html::Match.call(@html, exercise)
    end

    if result.any?
      @html_errors = result
    end

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

    #change exercise name
    exercise = "exercise"
    Html::NewFile.call(@html,exercise)

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


end
