# frozen_string_literal: true

require_relative './page_view'

module Counterview
  # Log parser
  class Parser
    # Parses given enumerable of log lines
    #
    # @param lines [Enumerable]
    # @return [Array<Counterview::PageView>]
    def parse(lines)
      lines.map { |line| parse_line(line) }.compact
    end

    private

    def parse_line(line)
      PageView.new(*line.split)
    rescue ArgumentError
      # Ignore unparsable lines
    end
  end
end
