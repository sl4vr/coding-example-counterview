# frozen_string_literal: true

require_relative './counter'

module Counterview
  # Total and unique view report builder for log files
  class FileProcessor
    FileProcessorError = Class.new(StandardError)

    TOTAL_VIEWS_TITLE = 'visits'
    UNIQUE_VIEWS_TITLE = 'unique views'

    # @param parser [Counterview::Parser]
    # @param sorter [Counterview::Sorter]
    # @param reporter [Counterview::Reporter]
    # @return [Counterview::Process]
    def initialize(
      parser:   Parser.new,
      sorter:   Sorter.new,
      reporter: Reporter.new
    )
      @parser   = parser
      @sorter   = sorter
      @reporter = reporter
    end

    # Outputs total and unique views report for given filename
    #
    # @param filename [String]
    # @return [void]
    def call(filename)
      page_views = File.open(filename, 'r') { |file| @parser.parse(file) }
      counter = Counter.new(page_views)

      total_tally = @sorter.sort(counter.total_view_counts_by_route)
      @reporter.output(total_tally, TOTAL_VIEWS_TITLE)

      unique_tally = @sorter.sort(counter.unique_view_counts_by_route)
      @reporter.output(unique_tally, UNIQUE_VIEWS_TITLE)
    rescue Errno::ENOENT => e
      raise FileProcessorError, e
    end
  end
end
