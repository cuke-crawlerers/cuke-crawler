require "spec_helper"

describe CukeCrawler::Adventurer do
  let(:dungeon) { CukeCrawler::Dungeon.new }
  let(:adventurer) { CukeCrawler::Adventurer.new(dungeon) }

  it "has a location" do
    expect(adventurer.location).to_not be_nil
  end

  it "starts at the dungeon entrance" do
    expect(adventurer.location).to eq(dungeon.entrance)
  end

  let(:methods) { (adventurer.methods - Object.methods).sort }

  it "has no other public methods" do
    expect(methods).to eq [
      :location,
    ]
  end
end
