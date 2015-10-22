require "spec_helper"

describe CukeCrawler::Pathfinder do
  let(:pathfinder) do
    CukeCrawler::Pathfinder.new(entrance) do |room|
      room == dungeon.goal
    end
  end

  let(:dungeon) { CukeCrawler::Dungeon.new }
  let(:entrance) { dungeon.entrance }
  let(:path) { pathfinder.path }

  describe "#path" do
    subject { path }

    it { is_expected.not_to be false }
    it { is_expected.to have_exactly(3).items }

    context "when the start room has no exits" do
      before do
        entrance.connections.clear
      end

      it { is_expected.to be false }
    end
  end

  describe "#route" do
    subject { pathfinder.route }

    it { is_expected.to eq([:north, :west]) }

    context "when the start room has no exits" do
      before do
        entrance.connections.clear
      end

      it { is_expected.to be false }
    end
  end
end
