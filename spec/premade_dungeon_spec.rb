require "spec_helper"

describe CukeCrawler::Dungeon do
  let(:dungeon) { CukeCrawler::Dungeon.new(seed) }
  let(:adventurer) { CukeCrawler::Adventurer.new(dungeon) }

  context "with the 'phobic ice' seed" do
    let(:seed) { "phobic ice" }

    it "looks like the map" do
      puts "\n#{dungeon.map}\n"
      expect(dungeon.map).to eq("+-+-+-+\n|     |\n+ +-+ +\n|!  | |\n+ + +-+\n|X|*  |\n+-+-+-+")
    end

    context "when running the dungeon" do
      before do
        adventurer.go(:east)
        adventurer.inventory << adventurer.location.loot.first
        adventurer.go(:west)
        adventurer.go(:north)
        adventurer.go(:west)
      end

      it "we have completed the dungeon" do
        expect(adventurer.location).to eq(dungeon.goal)
        expect(adventurer).to be_alive
      end
    end

    context "when going around in circles" do
      before do
        adventurer.go(:north)
        adventurer.go(:south)
      end

      it "we have not completed the dungeon" do
        expect(adventurer.location).not_to eq(dungeon.goal)
        expect(adventurer).to be_alive
      end
    end

    it "we fail if we try to go south" do
      expect {
        adventurer.go(:south)
      }.to raise_error CukeCrawler::RanIntoAWallError
    end
  end
end
