RSpec::Matchers.define :be_able_to_attack do |direction|
  match do |adventurer|
    adventurer.location.monster.present? &&
      adventurer.location.monster.alive?
  end

  failure_message do |adventurer|
    "You have nothing to attack here."
  end
end
