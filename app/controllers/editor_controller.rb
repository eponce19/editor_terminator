class EditorController < ApplicationController

  def index
    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".html"
    ct = CodeTerminator::Html.new
    @instructions = ct.read_file(source)
  end

  def check
    @html = params["editor"]
    @html_errors = Array.new
    result = Array.new

    #validate syntasis
    ct = CodeTerminator::Html.new
    errors = ct.validate_syntax(@html)
    result << errors[0]

    #change name of exercise
    exercise = "exercise"

    if errors.empty?
      source = "exercises/" + exercise + ".html"
      #ct = CodeTerminator::Html.new
      result = ct.match(source, @html)
    end

    if result.any?
      @html_errors = result
    end

  end


  def show

  end

  def upload
    @html = params["editor"]
    @html_errors = Array.new
    #validate syntasis
    ct = CodeTerminator::Html.new
    @html_errors = ct.validate_syntax(@html)

    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".html"
    ct.new_file(source,@html)

    #get elements of the html source
    elements = ct.get_elements(source)
    @elements = ct.print_elements(elements)

  end


end
