# frozen_string_literal: true

require 'raven'

Sentry.configure do |config|
  config.dsn = ENV.fetch('BST_SENTRY', nil)
end
