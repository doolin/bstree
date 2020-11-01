# frozen_string_literal: true

class Gcd
  def self.compute(a, b)
    return a if b.zero?

    compute(b, a.modulo(b))
  end

  def self.coprime?(a, b)
    compute(a, b) == 1
  end
end
