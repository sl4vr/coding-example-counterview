# frozen_string_literal: true

module Counterview
  # Descending tally sorter
  class Sorter
    # Sorts given hash where keys are some items and values are counts
    #
    # @param tally [Hash] tally
    # @return [Hash] sorted tally
    def sort(tally)
      tally.sort_by { |key, count| [-count, key] }.to_h
    end
  end
end
