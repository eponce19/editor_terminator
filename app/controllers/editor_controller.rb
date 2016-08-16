class EditorController < ApplicationController
  def index
    #change exercise name
    exercise = "new"
    source = "exercises/" + exercise + ".html"
    @instructions = Html::ReadFile.call(source)
  end

  def check
    @html = params["editor"]
    @html_errors = Array.new
    result = Array.new

    #validate syntasis
    errors = Html::ValidateSyntax.call(@html)
    result << errors[0]

    #change name of exercise
    exercise = "new"

    if errors.empty?
      source = "exercises/" + exercise + ".html"
      result = Html::Match.call(@html, source)
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
    @html_errors = Html::ValidateSyntax.call(@html)

    #change exercise name
    exercise = "exercise"
    source = "exercises/" + exercise + ".html"
    Html::NewFile.call(@html,source)

    #get elements of the html source
    elements = Html::GetElements.call(source)
    @elements = Html::PrintElements.call(elements)

  end


end
