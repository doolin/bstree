# frozen-string-literal: true

require 'raven'

Sentry.configure do |config|
  config.dsn = ENV['BST_SENTRY']
end
