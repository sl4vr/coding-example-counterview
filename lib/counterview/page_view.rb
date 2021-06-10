# frozen_string_literal: true

module Counterview
  # Data structure that holds information about page view
  class PageView
    # Yeah, it's confusing, but let's assume that it's IP address format :D
    IP_ADDRESS_FORMAT = /\A(?:\d{3}\.){3}\d{3}\z/.freeze

    attr_reader :route, :ip_address

    # @param route [String]
    # @param ip_address [String]
    # @return [Counterview::PageView]
    def initialize(route, ip_address)
      @route = route
      @ip_address = validate_ip_address!(ip_address)
    end

    private

    def validate_ip_address!(ip_address)
      raise ArgumentError, "ip_address has wrong formar: #{ip_address}" unless ip_address =~ IP_ADDRESS_FORMAT

      ip_address
    end
  end
end
