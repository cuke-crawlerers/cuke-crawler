RSpec::Matchers.define :be_able_to_go do |direction|
  match do |adventurer|
    adventurer.location.exit?(direction)
  end

  failure_message do |adventurer|
    "You cannot go #{direction} from here."
  end
end
