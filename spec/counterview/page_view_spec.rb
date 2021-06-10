# frozen_string_literal: true

require 'spec_helper'
require 'counterview/page_view'

RSpec.describe Counterview::PageView do
  subject(:page_view) { described_class.new(route, ip_address) }

  let(:route) { '/home' }
  let(:ip_address) { '123.123.123.123' }

  it { expect(page_view.route).to eq(route) }
  it { expect(page_view.ip_address).to eq(ip_address) }

  context 'when ip_address has invalid format' do
    let(:ip_address) { '123123123123' }

    it 'raises ArgumentError' do
      expect { page_view }.to raise_error(ArgumentError)
    end
  end
end
