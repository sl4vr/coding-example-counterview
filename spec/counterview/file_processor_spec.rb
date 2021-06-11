# frozen_string_literal: true

require 'spec_helper'
require 'counterview/file_processor'

RSpec.describe Counterview::FileProcessor, :integration do
  subject(:file_processor) { described_class.new }

  describe '#call' do
    context 'when file is empty' do
      let(:filename) { File.join(__dir__, 'fixtures', 'empty.log') }

      it 'outputs nothing' do
        expect { file_processor.call(filename) }.to output('').to_stdout
      end
    end

    context 'when file does not exist' do
      let(:filename) { File.join(__dir__, 'fixtures', 'not_existing.log') }

      it 'raises FileProcessorError exception' do
        expect { file_processor.call(filename) }.to raise_error(described_class::FileProcessorError)
      end
    end

    context 'when file is invalid' do
      let(:filename) { File.join(__dir__, 'fixtures', 'invalid.log') }

      let(:report) do
        <<~OUTPUT
          /about 15 visits
          /home 13 visits
          /contact 12 visits
          /help_page/1 12 visits
          /about/2 9 visits
          /index 4 visits
          /home 12 unique views
          /about 11 unique views
          /help_page/1 10 unique views
          /about/2 9 unique views
          /contact 8 unique views
          /index 4 unique views
        OUTPUT
      end

      it 'still outputs page view report and ignores broken lines' do
        expect { file_processor.call(filename) }.to output(report).to_stdout
      end
    end

    context 'when file is valid' do
      let(:filename) { File.join(__dir__, 'fixtures', 'valid.log') }

      let(:report) do
        <<~OUTPUT
          /about/2 90 visits
          /contact 89 visits
          /index 82 visits
          /about 81 visits
          /help_page/1 80 visits
          /home 78 visits
          /contact 23 unique views
          /help_page/1 23 unique views
          /home 23 unique views
          /index 23 unique views
          /about/2 22 unique views
          /about 21 unique views
        OUTPUT
      end

      it 'outputs page view report' do
        expect { file_processor.call(filename) }.to output(report).to_stdout
      end
    end
  end
end
