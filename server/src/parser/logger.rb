# frozen_string_literal: true

module Parser
  class Logger < Parser
    def initialize; end

    def parse_row(row:)
      require 'byebug'
      byebug
      row.split(', ').each do |kv|
        key, value = kv.split(': ')
        a.push({ key.to_sym => value })
      end
    end
  end
end
