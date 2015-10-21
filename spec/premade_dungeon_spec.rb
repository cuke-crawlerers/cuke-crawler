require "spec_helper"

describe CukeCrawler::Dungeon do
  let(:dungeon) { CukeCrawler::Dungeon.new(seed) }
  let(:adventurer) { CukeCrawler::Adventurer.new(dungeon) }

  context "with the 'phobic ice' seed" do
    let(:seed) { "phobic ice" }

    it "we can complete the dungeon" do
      expect(adventurer.location).to eq(dungeon.entrance)

      adventurer.go_north!

      expect(adventurer.location).to eq(dungeon.goal)
    end
  end
end
