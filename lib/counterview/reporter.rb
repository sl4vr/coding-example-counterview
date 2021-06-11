# frozen_string_literal: true

module Counterview
  # Report builder
  class Reporter
    # Reports tally to stdout
    #
    # @param tally [Hash] tally
    # @param title [String] title for tally
    # @return [void]
    def output(tally, title)
      tally.each do |route, count|
        puts "#{route} #{count} #{title}"
      end
    end
  end
end
