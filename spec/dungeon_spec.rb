require "spec_helper"

describe CukeCrawler::Dungeon do
  let(:dungeon) { CukeCrawler::Dungeon.new }

  it "has an entrance" do
    expect(dungeon.entrance).to_not be_nil
  end

  it "has a goal" do
    expect(dungeon.goal).to_not be_nil
  end

  it "has a different entrance to goal" do
    expect(dungeon.entrance).to_not eq(dungeon.goal)
  end

  let(:methods) { (dungeon.methods - Object.methods).sort }

  it "has no other public methods" do
    expect(methods).to eq [
      :entrance,
      :goal,
    ]
  end

  context "can support a seed" do
    let(:seed) { "phobic ice" }
    let(:dungeon) { CukeCrawler::Dungeon.new(seed) }

    it "has an entrance" do
      expect(dungeon.entrance).to_not be_nil
    end

    it "has a goal" do
      expect(dungeon.goal).to_not be_nil
    end

    context "and must be a pleasant lawyer name" do
      let(:seed) { "i'm not a pleasant lawyer name" }

      it "is not valid" do
        expect {
          dungeon.entrance
        }.to raise_error ArgumentError
      end
    end
  end
end
