# frozen_string_literal: true

require_relative 'generator'

class ImageGenerator < Generator
  def initialize(html:)
    @html = html
    @kit = IMGKit.new(html, quality: 50)
  end

  def generate
    kit.to_img
  end

  def save(path: './')
    kit.to_file("#{path}file.jpg")
  end
end
=begin
path = "path/to/html"
html = File.open(path)
kit = IMGKit.new(html, quality: 50)
kit.to_file('answer.jpg')
end
