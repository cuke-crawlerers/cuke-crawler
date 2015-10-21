Given(/^I am at the entrance to the (\w+ \w+) dungeon$/) do |name|
  @dungeon = Crawler::Dungeon.generate(name)
  @adventurer = Crawler::Adventurer.new(@dungeon)
end

Then(/^my quest is complete$/) do
end
