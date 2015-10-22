require "rspec"
require "rspec/collection_matchers"
require "active_support"
require "active_support/dependencies"

ActiveSupport::Dependencies.autoload_paths = %w(lib)

$running_from_rspec = true
