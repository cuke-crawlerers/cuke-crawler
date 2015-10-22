RSpec::Matchers.define :be_able_to_leave do
  match do |adventurer|
    adventurer.location.monster == nil || !adventurer.location.monster.alive?
  end

  failure_message do |adventurer|
    "You cannot leave."
  end
end
