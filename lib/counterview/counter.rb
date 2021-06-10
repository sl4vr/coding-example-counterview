# frozen_string_literal: true

module Counterview
  # Page view counter
  class Counter
    # @param page_views [Array<Counterview::PageView>]
    # @return [Counterview::Counter]
    def initialize(page_views)
      @page_views = page_views
    end

    # Calculates total page view count per route
    #
    # @return [Hash] tally of page views
    def total_view_counts_by_route
      page_views_by_route.transform_values(&:count)
    end

    # Calculates unique page view count per route
    #
    # @return [Hash] tally of page views
    def unique_view_counts_by_route
      page_views_by_route.transform_values { |page_views| page_views.uniq(&:ip_address).count }
    end

    private

    def page_views_by_route
      @page_views.group_by(&:route)
    end
  end
end
