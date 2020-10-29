# frozen_string_literal: true

require 'json'
require_relative 'request'

class Parser
  def initialize; end

  def text_html?(content_type:)
    content_type == 'text/html'
  end

  def application_json?(content_type:)
    content_type == 'application/json'
  end

  def application_x_www_form?(content_type:)
    content_type == 'application/x-www-form-urlencoded'
  end

  def empty_line?(str:)
    str == "\r\n"
  end

  def normalize(header:)
    header.gsub(':', '').downcase.to_sym
  end

  def normalize_body(body:)
    body.reject do |line|
      line.eql?("\r\n")
    end
  end

  # Only supports HTML at the moment
  def parse_body(lines:, content_type:, method:)
    if application_json?(content_type: content_type) && method == 'POST'
      JSON.parse(normalize_body(body: lines)[0]).transform_keys(&:to_sym)
    elsif text_html?(content_type: content_type)
      html_string = ''
      lines.each do |line|
        html_string += line
      end
      html_string
    end
  end

  def parse_headers; end

  def parse_request(request:, method:)
    headers = {}
    body_start = 0

    request.lines[1..-1].each_with_index do |line, index|
      body_start = index
      break if line == "\r\n"

      header, value = line.split
      header = normalize(header: header)
      headers[header] = value
    end

    body = parse_body(
      lines: request.lines[body_start + 1..-1],
      content_type: headers[:"content-type"],
      method: method
    )

    { headers: headers, body: body }
  end

  def read(request:)
    method, path, _version = request.lines[0].split
    Request.new(
      path: path,
      method: method,
      headers: parse_request(request: request, method: method)[:headers],
      body: parse_request(request: request, method: method)[:body]
    )
  end
end
