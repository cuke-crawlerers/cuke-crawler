Given(/^I am at the entrance to the (\w+ \w+) dungeon$/) do |name|
  @dungeon = CukeCrawler::Dungeon.generate(name)
  @adventurer = CukeCrawler::Adventurer.new(@dungeon)
  @started = true
end

Then(/^my quest is complete$/) do
  expect(@started).to be_true, "You never started at the entrance"
  expect(@adventurer).to be_alive, "You are dead"
  expect(@adventurer.location).to eq(@dungeon.goal), "You are still stuck in the dungeon"
end
