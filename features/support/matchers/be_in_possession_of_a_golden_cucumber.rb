RSpec::Matchers.define :be_in_possession_of_a_golden_cucumber do |direction|
  match do |adventurer|
    adventurer.inventory.any?(&:golden_cucumber?)
  end

  failure_message do |adventurer|
    "You do not hold the golden cucumber."
  end
end
