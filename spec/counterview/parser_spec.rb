# frozen_string_literal: true

require 'spec_helper'
require 'counterview/parser'

RSpec.describe Counterview::Parser do
  subject(:parser) { described_class.new }

  describe '#parse' do
    subject(:parse_result) { parser.parse(lines) }

    RSpec.shared_examples 'valid parse result' do |line_count|
      it { is_expected.to all(be_kind_of(Counterview::PageView)) }
      it { expect(parse_result.size).to eq(line_count) }
    end

    let(:lines) do
      [
        '/home 111.111.111.111',
        '/help 222.222.222.222',
        '/home 111.111.111.111'
      ]
    end

    it_behaves_like 'valid parse result', 3

    context 'when input contains lines without ip address' do
      let(:lines) do
        [
          '/home 111.111.111.111',
          '/help',
          '/home 111.111.111.111'
        ]
      end

      it_behaves_like 'valid parse result', 2
    end

    context 'when input contains lines with invalid ip address' do
      let(:lines) do
        [
          '/home 111.111.111.111',
          '/help 111',
          '/home 111.111.111.111'
        ]
      end

      it_behaves_like 'valid parse result', 2
    end

    context 'when input contains empty lines' do
      let(:lines) do
        [
          '/home 111.111.111.111',
          '',
          '/home 111.111.111.111'
        ]
      end

      it_behaves_like 'valid parse result', 2
    end

    context 'when input is empty' do
      let(:lines) { [] }

      it { is_expected.to be_empty }
    end
  end
end
