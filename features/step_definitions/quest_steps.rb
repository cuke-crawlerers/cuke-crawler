Given(/^I am at the entrance to the (\w+ \w+) dungeon$/) do |name|
  @dungeon = CukeCrawler::Dungeon.generate(name)
  @adventurer = CukeCrawler::Adventurer.new(@dungeon)
end

Then(/^my quest is complete$/) do
  expect(@adventurer).to be_alive, "You are dead"
  expect(@adventurer.location).to eq(@dungeon.goal), "You are still stuck in the dungeon"
end
