require 'rubygems'
require 'nokogiri'
require 'open-uri'

class NokogiriController < ApplicationController

  def index
    @page = Nokogiri::HTML(open("http://codechangers.com/"))
    #@page = page.class   # => Nokogiri::HTML::Document
    #code
  end

end
