# frozen_string_literal: true

require 'spec_helper'
require 'counterview/reporter'

RSpec.describe Counterview::Reporter do
  subject(:reporter) { described_class.new }

  describe '#output' do
    let(:tally) { { '/d' => 3, '/c' => 3, '/b' => 2, '/a' => 1, '/e' => 4 } }
    let(:tally_title) { 'bananas' }
    let(:report) do
      <<~REPORT
        /d 3 bananas
        /c 3 bananas
        /b 2 bananas
        /a 1 bananas
        /e 4 bananas
      REPORT
    end

    before { allow($stdout).to receive(:puts).and_return(nil) }

    it 'outputs report for given rally' do
      expect { reporter.output(tally, tally_title) }.to output(report).to_stdout
    end
  end
end
