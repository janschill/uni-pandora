# frozen_string_literal: true

require 'socket'
require_relative 'src/parser'
require_relative 'src/router'

LOCATION = 'localhost'
PORT = 8080

server = TCPServer.new(LOCATION, PORT)
puts "Server started on #{LOCATION}, listening on port: #{PORT}"

def now_iso_8601
  Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
end

def log_request(request:)
  "#{now_iso_8601} "\
    "#{request[:headers][:"user-agent"]} "\
    "#{request[:method]} "\
    "#{request[:path]} "\
    "#{request[:body]}"
end

loop do
  client = server.accept
  request = client.readpartial(2048)
  puts request
  request = Parser.new.read(request: request)
  response = Router.new.respond(request: request)

  puts log_request(request: request)
  response.send(client: client)
  client.close
end
