# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/gcd'

# Greatest Common Divisor
RSpec.describe Gcd do
  describe '.compute' do
    it 'finds 21 for 1071, 462' do
      expect(described_class.compute(1071, 462)).to eq 21
    end

    example 'gcd(2, 1)' do
      expect(described_class.compute(2, 1)).to eq 1
    end

    example 'gcd(4, 2)' do
      expect(described_class.compute(4, 2)).to eq 2
    end

    example 'gcd(17, 1)' do
      expect(described_class.compute(17, 1)).to eq 1
    end

    example 'gcd(48, 18)' do
      expect(described_class.compute(48, 18)).to eq 6
    end

    example 'gcd(18, 48)' do
      expect(described_class.compute(18, 48)).to eq 6
    end

    example 'gcd(17*23, 5*17)' do
      expect(described_class.compute(17 * 23, 5 * 17)).to eq 17
    end

    example 'gcd(0, 18)' do
      expect(described_class.compute(0, 18)).to eq 18
    end

    example 'gcd(577, 97) primes' do
      expect(described_class.compute(577, 97)).to eq 1
    end
  end

  describe '.coprime?' do
    example 'coprime(17, 1)' do
      expect(described_class.coprime?(17, 1)).to be true
    end

    example 'coprime(3, 5)' do
      expect(described_class.coprime?(3, 5)).to be true
    end

    example 'coprime(17, 23)' do
      expect(described_class.coprime?(17, 23)).to be true
    end

    example 'coprime(6, 8)' do
      expect(described_class.coprime?(6, 8)).to be false
    end
  end
end
