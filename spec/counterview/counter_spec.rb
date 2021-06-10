# frozen_string_literal: true

require 'spec_helper'
require 'counterview/counter'

RSpec.describe Counterview::Counter do
  subject(:counter) { described_class.new(page_views) }

  let(:page_views) do
    [
      instance_double('PageView', route: '/home', ip_address: '111.111.111.111'),
      instance_double('PageView', route: '/home', ip_address: '222.222.222.222'),
      instance_double('PageView', route: '/help', ip_address: '111.111.111.111'),
      instance_double('PageView', route: '/home', ip_address: '111.111.111.111'),
      instance_double('PageView', route: '/help', ip_address: '222.222.222.222'),
      instance_double('PageView', route: '/home', ip_address: '222.222.222.222')
    ]
  end

  describe '#total_view_counts_by_route' do
    it 'returns tally for total views per page' do
      expect(counter.total_view_counts_by_route).to eq({ '/home' => 4, '/help' => 2 })
    end
  end

  describe '#unique_view_counts_by_route' do
    it 'returns tally for unique views per page' do
      expect(counter.unique_view_counts_by_route).to eq({ '/home' => 2, '/help' => 2 })
    end
  end
end
