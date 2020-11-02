# frozen_string_literal: true

require_relative 'generator'

class HTMLGenerator < Generator
  def initialize(html_string:)
    @html_string = html_string
  end

  def generate
    kit.to_img
  end

  def save(path: './')
    IO.binwrite("#{path}answer.html", @html_string)
    kit.to_file("#{path}file.jpg")
  end
end
