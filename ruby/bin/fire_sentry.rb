#!/usr/bin/env ruby
# frozen-string-literal: true

require_relative '../config/sentry'

begin
  1 / 0
rescue ZeroDivisionError => e
  Sentry.capture_exception(e)
end
