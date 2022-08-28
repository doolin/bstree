# frozen_string_literal: true

require 'spec_helper'

require 'shared_examples/insert'
require 'shared_examples/maximum'
require 'shared_examples/minimum'
require 'shared_examples/successor'
require 'shared_examples/predecessor'

require_relative '../lib/iterative_node'

RSpec.describe IterativeNode do # rubocop:disable RSpec/EmptyExampleGroup # false positive
  it_inserts_like 'insertion'
  it_finds_extremes '#maximum'
  it_finds_extremes '#minimum'

  it_finds '#successor'
  it_finds '#predecessor'
end
