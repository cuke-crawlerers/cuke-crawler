require "spec_helper"

describe CukeCrawler::Dungeon do
  let(:dungeon) { CukeCrawler::Dungeon.new(seed) }
  let(:adventurer) { CukeCrawler::Adventurer.new(dungeon) }

  context "with the 'phobic ice' seed" do
    let(:seed) { "phobic ice" }

    context "when running the dungeon" do
      before do
        adventurer.go_north!
      end

      it "we have completed the dungeon" do
        expect(adventurer.location).to eq(dungeon.goal)
        expect(adventurer).to be_alive
      end
    end

    context "when going around in circles" do
      before do
        adventurer.go_north!
        adventurer.go_south!
      end

      it "we have not completed the dungeon" do
        expect(adventurer.location).to_not eq(dungeon.goal)
        expect(adventurer).to be_alive
      end
    end

    it "we fail if we try to go south" do
      expect {
        adventurer.go_south!
      }.to raise_error CukeCrawler::Error
    end
  end
end
