# frozen_string_literal: true

# TODO: spend some serious time checking the impplementation
# against the algorithn and the theory. Use Knuth et al. for
# properties of the tree.
# Stern Brocot trees have the binary search property.
class SternBrocot
  MAX = (2**((1.size * 8) - 2)) - 1
  TOL = 0.00001

  # Initialize two values L and H to 0/1 and 1/0, respectively.
  #  Until q is found, repeat the following steps:
  #  Let L = a/b and H = c/d; compute the mediant M = (a + c)/(b + d).
  #  If M is less than q, then q is in the open interval (M,H); replace L by M and continue.
  #  If M is greater than q, then q is in the open interval (L,M); replace H by M and continue.
  #  In the remaining case, q = M; terminate the search algorithm.
  # rubocop:disable Metrics/MethodLength
  def self.rationalize(number) # rubocop:disable  Metrics/AbcSize
    return [0, 1] if number.to_f == 0.0 # rubocop:disable Lint/FloatComparison

    q = number

    a = 0
    b = 1
    c = 1
    d = 0

    l = a / b
    h = d.zero? ? MAX : c / d
    mediant_numerator = a + c
    mediant_denominator = b + d
    mediant = mediant_numerator.fdiv(mediant_denominator)

    iteration = 1 # ejection handle

    loop do
      return [mediant_numerator.to_i, mediant_denominator.to_i] if mediant == q

      if mediant < q
        a = mediant_numerator
        b = mediant_denominator
        l = mediant
      else # m > q
        c = mediant_numerator
        d = mediant_denominator
        h = mediant
      end

      mediant_numerator = a + c
      mediant_denominator = b + d
      mediant = mediant_numerator.fdiv(mediant_denominator)

      # return [mediant_numerator.to_i, mediant_denominator.to_i] if m == q
      return [mediant_numerator.to_i, mediant_denominator.to_i] if (mediant - q).abs < TOL

      # return [l.to_i, h.to_i] if (mediant - q).abs < TOL

      iteration += 1
      # puts mediant_denominator.to_i if mediant_denominator.to_i.modulo(10).zero?
      break if iteration > 20
    end

    # also, return if past a certain threshold in precision
    # return [a+b, c+d] if Math.abs(q - number) < 0.0005
    [mediant_numerator.to_i, mediant_denominator.to_i]
  end
  # rubocop:enable Metrics/MethodLength
end
