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

When(/^I (?:check|look (?:at|in|through)) my inventory$/) do
  expect(adventurer).to be_alive, "You are dead."
  message(adventurer.inventory.look)
end

When(/^I attack the (.*)$/) do |monster|
  monster = location.monsters.detect do |candidate|
    monster =~ Regexp.new(candidate.name, "i")
  end
  expect(monster).to be_present, "You can't see that here."
  expect(adventurer).to be_carrying(CukeCrawler::Loot::Weapon),
    "You can't fight with your bare hands!"
  expect(adventurer).to be_alive, "You are dead."
  expect(adventurer).to be_able_to_attack
  adventurer.attack!(monster)
end

When(/^I (?:pick up|take|get) (?:a|the) (.*)$/) do |item|
  expect(adventurer).to be_alive, "You are dead."
  item = adventurer.location.loot.detect do |candidate|
    item =~ Regexp.new(candidate.name, "i")
  end
  expect(item).to be_present, "You can't see that here."
  adventurer.inventory << location.loot.drop(item)
  message "You pick up the #{item.name}."
end

When(/^I (?:pick up|take|get) everything$/) do
  expect(location.loot).not_to be_empty, "There's nothing worth taking."
  location.loot.dup.each { |item| step("I take the #{item.name}") }
end

Then(/^my quest is complete$/) do
  expect(adventurer).to be_alive, "You are dead."
  expect(@started).to eq(true), "You must begin your quest at the dungeon's entrance."
  expect(adventurer).to be_in_location(dungeon.goal)
  expect(adventurer).to be_carrying(CukeCrawler::Loot::GoldenCucumber)
  expect(location.monsters.select(&:alive?)).to be_empty, "There are still adversaries to be defeated."
  message "A shaft of light from somewhere overhead glints brightly off the magnificent golden cucumber as you hold it aloft in triumph. Your quest is at an end, and turned out to involve hardly any spiders."
end
