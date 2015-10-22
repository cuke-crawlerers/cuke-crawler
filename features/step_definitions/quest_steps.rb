Given(/^I am at the entrance to the (\w+ \w+) dungeon$/) do |name|
  @dungeon = CukeCrawler::Dungeon.generate(name)
  @adventurer = CukeCrawler::Adventurer.new(@dungeon)
  @started = true

  message "You enter #{@dungeon.description}."
end

When(/^I go (\w+)$/) do |direction|
  expect(adventurer).to be_alive, "You are dead."
  expect(adventurer).to be_able_to_leave
  expect(adventurer).to be_able_to_go(direction)
  adventurer.go(direction)
end

When(/^I look around$/) do
  message @adventurer.location.look
end

When(/^I look (?:at|in|through) my inventory$/) do
  message @adventurer.inventory.look
  expect(adventurer).to be_alive, "You are dead."
end

When(/^I attack$/) do
  expect(adventurer).to be_alive, "You are dead."
  expect(@adventurer).to be_able_to_attack
  adventurer.attack!
end

When(/^I pick up the golden cucumber$/) do
  expect(adventurer).to be_alive, "You are dead."
  expect(adventurer.location.loot).not_to be_empty, "There is nothing here to pick up"
  expect(adventurer.location.loot.first).to be_a_golden_cucumber
  adventurer.location.loot.drop_all!.each do |item|
    adventurer.inventory << item
  end
end

Then(/^my quest is complete$/) do
  expect(@started).to eq(true), "You must begin your quest at the dungeon's entrance."
  expect(adventurer).to be_alive, "You are dead."
  expect(adventurer).to be_in_location(dungeon.goal)
  expect(adventurer).to be_in_possession_of_a_golden_cucumber
  message "You are indeed a mighty hero."
end
