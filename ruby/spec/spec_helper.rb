# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch
end

require 'ap'
require 'debug'

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '**.rb')].each do |f|
  require f
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.alias_it_should_behave_like_to :it_inserts_like, ''
  config.alias_it_should_behave_like_to :it_finds_extremes, ''
  config.alias_it_should_behave_like_to :it_traverses_with, ''
  config.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'
end
