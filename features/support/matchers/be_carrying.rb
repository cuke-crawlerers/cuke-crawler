RSpec::Matchers.define :be_carrying do |item|
  match do |adventurer|
    adventurer.inventory.include?(item)
  end

  failure_message do |adventurer|
    "You are not carrying #{item.new.description}."
  end
end
