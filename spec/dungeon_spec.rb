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

  describe "map" do
    subject { dungeon.map }

    it { is_expected.to eq("+-+-+-+\n|  !  |\n+ +-+-+\n| | | |\n+ + + +\n|  *  |\n+-+-+-+") }
  end

  context "the entrance" do
    let(:location) { dungeon.entrance }

    it "has connections" do
      expect(location.connections).to_not be_empty
    end
  end

  context "the goal" do
    let(:location) { dungeon.goal }

    it "has connections" do
      expect(location.connections).to_not be_empty
    end
  end

  let(:methods) { (dungeon.methods - Object.methods).sort }

  it "has no other public methods" do
    expect(methods).to eq [
      :description,
      :entrance,
      :goal,
      :map,
      :options
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
