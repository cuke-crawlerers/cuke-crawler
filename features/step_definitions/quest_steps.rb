Given(/^I am at the entrance to the (\w+ \w+) dungeon$/) do |name|
  @dungeon = CukeCrawler::Dungeon.generate(name)
  @adventurer = CukeCrawler::Adventurer.new(@dungeon)
  @started = true

  message "You enter #{@dungeon.description}."
end

When(/^I go (\w+)$/) do |direction|
  expect(adventurer).to be_able_to_leave
  expect(adventurer).to be_able_to_go(direction)
  adventurer.go(direction)
end

When(/^I look around$/) do
  message @adventurer.location.look
end

When(/^I attack$/) do
  expect(@adventurer).to be_able_to_attack
  adventurer.attack!
end

When(/^I pick up the golden cucumber$/) do
  expect(adventurer.location.loot).to_not be_nil, "There is nothing here to pick up"
  expect(adventurer.location.loot).to be_a_golden_cucumber
  adventurer.inventory << adventurer.location.loot
  adventurer.location.loot = nil
end

Then(/^my quest is complete$/) do
  expect(@started).to eq(true), "You must begin your quest at the dungeon's entrance."
  expect(adventurer).to be_alive, "You have perished."
  expect(adventurer).to be_in_location(dungeon.goal)
  expect(adventurer).to be_in_possession_of_a_golden_cucumber
  message "You are indeed a mighty hero."
end
