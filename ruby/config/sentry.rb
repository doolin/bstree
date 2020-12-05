# frozen-string-literal: true

require 'raven'

Raven.configure do |config|
  config.dsn = ENV['BST_SENTRY']
end
