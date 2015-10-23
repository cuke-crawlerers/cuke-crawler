Given(/^I am at the entrance to the (\w+ \w+ |)dungeon$/) do |name|
  name = name.strip
  name = nil if name.empty?
  @dungeon = CukeCrawler::Dungeon.generate(name)
  @adventurer = CukeCrawler::Adventurer.new(@dungeon)
  @started = true
  @score = 0

  message "You enter #{@dungeon.description}."
end

When(/^I go (\w+)$/) do |direction|
  expect(adventurer).to be_alive, "You are dead."
  expect(adventurer).to be_able_to_leave
  expect(adventurer).to be_able_to_go(direction)

  adventurer.go(direction)
  @score -= 1
end

When(/^I look around$/) do
  message(adventurer.location.look)
  @score -= 1
end

When(/^I (?:check|look (?:at|in|through)) my inventory$/) do
  expect(adventurer).to be_alive, "You are dead."
  message(adventurer.inventory.look)
  @score -= 1
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
  @score += 5
end

When(/^I (?:pick up|take|get) (?:a|the) (.*)$/) do |item|
  expect(adventurer).to be_alive, "You are dead."
  item = adventurer.location.loot.detect do |candidate|
    item =~ Regexp.new(candidate.name, "i")
  end
  expect(item).to be_present, "You can't see that here."

  adventurer.inventory << location.loot.drop(item)
  @score += 10
end

Then(/^my quest is complete$/) do
  expect(adventurer).to be_alive, "You are dead."
  expect(@started).to eq(true), "You must begin your quest at the dungeon's entrance."
  expect(adventurer).to be_in_location(dungeon.goal)
  expect(adventurer).to be_carrying(CukeCrawler::Loot::GoldenCucumber)
  expect(location.monsters.select(&:alive?)).to be_empty, "There are still adversaries to be defeated."

  @score += 20
  message "A shaft of light from somewhere overhead glints brightly off the magnificent #{"golden cucumber".bold_words} as you hold it aloft in triumph. Your quest is at an end, and turned out to involve hardly any spiders."
  message "You are victorious with #{@score.to_s.bold_words} points."
end
