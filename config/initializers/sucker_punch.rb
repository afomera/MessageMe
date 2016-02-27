# TODO: Remove this when upgrading to Rails 5
# This keeps backward compatability for rails 5 and under
require 'sucker_punch/async_syntax'

Rails.application.configure do
  config.active_job.queue_adapter = :sucker_punch
end
