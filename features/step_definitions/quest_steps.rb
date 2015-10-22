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
  message(adventurer.location.look)
end

When(/^I look (?:at|in|through) my inventory$/) do
  expect(adventurer).to be_alive, "You are dead."
  message(adventurer.inventory.look)
end

When(/^I attack$/) do
  expect(adventurer).to be_carrying(CukeCrawler::Loot::Weapon),
    "You can't fight with your bare hands!"
  expect(adventurer).to be_alive, "You are dead."
  expect(adventurer).to be_able_to_attack
  adventurer.attack!
end

When(/^I pick up (?:a|the) (.*)$/) do |item|
  expect(adventurer).to be_alive, "You are dead."
  object = adventurer.location.loot.detect do |candidate|
    item =~ Regexp.new(candidate.name, "i")
  end
  expect(object).to be_present, "You can't see that here."
  adventurer.inventory << location.loot.drop(object)
end

Then(/^my quest is complete$/) do
  expect(adventurer).to be_alive, "You are dead."
  expect(@started).to eq(true), "You must begin your quest at the dungeon's entrance."
  expect(adventurer).to be_in_location(dungeon.goal)
  expect(adventurer).to be_carrying(CukeCrawler::Loot::GoldenCucumber)
  message "You are indeed a mighty hero."
end
