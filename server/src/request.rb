# frozen_string_literal: true

class Request
  attr_accessor :path, :method, :headers, :body

  def initialize(path: '', method: '', headers: [], body: nil)
    @path = path
    @method = method.to_sym
    @headers = headers
    @body = body
  end
end
