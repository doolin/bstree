# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/stern_brocot'

RSpec.describe SternBrocot do
  it 'instantiates' do
    expect(described_class.new).not_to be_nil
  end

  describe '.rationalize' do
    context 'when integers >= 0' do
      example '0 yields 0/1' do
        actual = described_class.rationalize 0
        expect(actual).to eq [0, 1]
      end

      example '1 yields 1/1' do
        actual = described_class.rationalize 1
        expect(actual).to eq [1, 1]
      end

      example '2 yields 2/1' do
        actual = described_class.rationalize 2
        expect(actual).to eq [2, 1]
      end

      example '13 yields 13/1' do
        actual = described_class.rationalize 13
        expect(actual).to eq [13, 1]
      end

      example '99 yields 99/1' do
        skip 'TODO: either correct this spec or delete it'
        actual = described_class.rationalize 99
        expect(actual).to eq [99, 1]
      end

      example '731 yields 731/1' do
        skip 'TODO: either correct this spec or delete it'
        actual = described_class.rationalize 731
        expect(actual).to eq [731, 1]
      end

      example '1246 yields 1246/1' do
        skip 'TODO: either correct this spec or delete it'
        actual = described_class.rationalize 1246
        expect(actual).to eq [1246, 1]
      end
    end

    context 'when rational numbers <= 1.0' do
      example '0.0 yields 0/1' do
        actual = described_class.rationalize 0.0
        expect(actual).to eq [0, 1]
      end

      example '1.0 yields 1/1' do
        actual = described_class.rationalize 1.0
        expect(actual).to eq [1, 1]
      end

      example '0.5 yields 1/2' do
        actual = described_class.rationalize 0.5
        expect(actual).to eq [1, 2]
      end

      example '0.1 yields 1/10' do
        actual = described_class.rationalize 0.1
        expect(actual).to eq [1, 10]
      end

      example '0.15 yields 15/100' do
        actual = described_class.rationalize 0.15
        # expect(actual).to eq [15, 100]
        expect(actual).to eq [3, 20]
      end

      example '0.3 yields 3/10' do
        actual = described_class.rationalize 0.3
        expect(actual).to eq [3, 10]
      end

      example '0.33 yields 33/100' do
        skip 'TODO: either correct this spec or delete it'
        actual = described_class.rationalize 0.33
        expect(actual).to eq [33, 100]
      end

      example '0.333 yields 333/1000' do
        skip 'TODO: either correct this spec or delete it'
        actual = described_class.rationalize 0.333
        # binding.pry
        expect(actual).to eq [333, 1000]
      end
    end

    context 'when rational numbers > 1.0' do
      example '1.1 yields 11/10' do
        skip 'TODO: either correct this spec or delete it'
        actual = described_class.rationalize 1.1
        expect(actual).to eq [11, 10]
      end

      # example '3.1'
      # example '5.2'
      # example '9.9'
      # example '123.123'
    end

    #     context 'irrational numbers' do
    #       context 'pi' do
    #         example 'to 1 decimal place'
    #         example 'to 2 decimal places'
    #         example 'to 3 decimal places'
    #         example 'to 4 decimal places'
    #         example 'to 5 decimal places'
    #       end
    #
    #       context 'e' do
    #         example 'to 1 decimal place'
    #         example 'to 2 decimal places'
    #         example 'to 3 decimal places'
    #         example 'to 4 decimal places'
    #         example 'to 5 decimal places'
    #       end
    #     end
  end
end
