class EditorController < ApplicationController

  def index
    #HTML
    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".html"
    ct = CodeTerminator::Html.new
    @html_instructions = ct.read_file(source)

    #CSS
    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".css"
    ct = CodeTerminator::Css.new
    @css_instructions = ct.read_file(source)

  end

  def check
    #HTML
    @html = params["html_editor"]
    @html_errors = Array.new
    html_result = Array.new

    #validate syntasis
    html_ct = CodeTerminator::Html.new
    html_errors = html_ct.validate_syntax(@html)
    html_result << html_errors[0]

    p "source elements"
    exercise = "exercise"
    source = "exercises/" + exercise + ".html"
    p html_ct.get_elements(source)
    # p "html elements"
    # p html_ct.get_elements(@html)
    #change name of exercise
    exercise = "exercise"
    if html_errors.empty?
      source = "exercises/" + exercise + ".html"
      #ct = CodeTerminator::Html.new
      html_result = html_ct.match(source, @html)
    end
    if html_result.any?
      @html_errors = html_result
    end


    #CSS
    @css = params["css_editor"]
    @css_errors = Array.new
    css_result = Array.new
    css_errors = Array.new

    #validate syntasis
    css_ct = CodeTerminator::Css.new
    css_errors = css_ct.validate_syntax(@css)
    # p "valid " + css_valid.to_s
    css_result << css_errors[0]

    #change name of exercise
    exercise = "exercise"
    if css_errors.empty?
      source = "exercises/" + exercise + ".css"
      #ct = CodeTerminator::Html.new
      css_result = css_ct.match(source, @css)
    end
    if css_result.any?
      @css_errors = css_result
    end

  end


  def show

  end

  def upload
    #HTML
    @html = params["html_editor"]
    @html_errors = Array.new
    #validate syntasis
    html_ct = CodeTerminator::Html.new
    @html_errors = html_ct.validate_syntax(@html)

    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".html"
    html_ct.new_file(source,@html)

    #get elements of the html source
    html_elements = html_ct.get_elements(source)
    @html_elements = nil#html_ct.print_elements(source)

    #CSS
    @css = params["css_editor"]
    #@css_errors = Array.new
    #validate syntasis
    css_ct = CodeTerminator::Css.new
    @css_errors = css_ct.validate_syntax(@css)

    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".css"
    css_ct.new_file(source,@css)

    #get elements of the html source
    css_elements = css_ct.get_elements(source)
    @css_elements = nil#css_ct.print_elements(source)

  end


end
