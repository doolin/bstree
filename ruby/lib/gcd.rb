# frozen_string_literal: true

class Gcd
  # rubocop:disable Naming/MethodParameterName
  def self.compute(a, b)
    return a if b.zero?

    compute(b, a.modulo(b))
  end
  # rubocop:enable Naming/MethodParameterName

  # rubocop:disable Naming/MethodParameterName
  def self.coprime?(a, b)
    compute(a, b) == 1
  end
  # rubocop:enable Naming/MethodParameterName
end
