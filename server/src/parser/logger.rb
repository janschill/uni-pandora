# frozen_string_literal: true

module Parser
  class Logger < Parser
    def initialize; end

    def parse_row(row:)
      row_parsed = {}
      row.split(', ').each do |kv|
        key, value = kv.split(': ')
        row_parsed[key.to_sym] = value
      end
      row_parsed
    end
  end
end
