# frozen_string_literal: true

RSpec.describe 'Flaky' do
  # Save for later.
  it 'fails 20% of the time' do
    actual = true
    expect(actual).to be(true) # (false) if rand < 0.2
  end
end
