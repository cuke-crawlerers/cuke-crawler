RSpec::Matchers.define :be_a_golden_cucumber do
  match do |loot|
    loot.golden_cucumber?
  end

  failure_message do |loot|
    "This is not a golden cucumber."
  end
end
