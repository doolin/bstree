# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/stern_brocot'

RSpec.describe SternBrocot do
  it 'instantiates' do
    expect(described_class.new).not_to be_nil
  end

  describe '.rationalize' do
    context 'integers >= 0' do
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

      xexample '1246 yields 1246/1' do
        actual = described_class.rationalize 1246
        expect(actual).to eq [1246, 1]
      end
    end

    context 'rational numbers <= 1.0' do
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

      xexample '0.15 yields 15/100' do
        actual = described_class.rationalize 0.15
        expect(actual).to eq [15, 100]
      end

      xexample '0.3 yields 3/10' do
        actual = described_class.rationalize 0.3
        expect(actual).to eq [3, 10]
      end

      xexample '0.333 yields 333/1000' do
        actual = described_class.rationalize 0.333
        expect(actual).to eq [333, 1000]
      end
    end

    context 'rational numbers > 1.0' do
      xexample '1.1 yields 11/10' do
        actual = described_class.rationalize 1.1
        expect(actual).to eq [11, 10]
      end

      example '3.1'
      example '5.2'
      example '9.9'
      example '123.123'
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
