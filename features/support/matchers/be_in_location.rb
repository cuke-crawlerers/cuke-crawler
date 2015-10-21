RSpec::Matchers.define :be_in_location do |expected|
  match do |adventurer|
    adventurer.location == expected
  end

  failure_message do |adventurer|
    "You are not where you expected to be."
  end
end
