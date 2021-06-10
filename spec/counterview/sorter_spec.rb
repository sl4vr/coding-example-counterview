# frozen_string_literal: true

require 'spec_helper'
require 'counterview/sorter'

RSpec.describe Counterview::Sorter do
  subject(:sorter) { described_class.new }

  describe '#sort' do
    subject(:sort_result) { sorter.sort(tally) }

    let(:tally) { { '/d' => 3, '/c' => 3, '/b' => 2, '/a' => 1, '/e' => 4 } }

    it { is_expected.to be_kind_of(Hash) }

    it 'sorts hash DESC on values and then ASC on keys' do
      expect(sort_result.keys).to eq(%w[/e /c /d /b /a])
    end
  end
end
