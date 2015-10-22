require "spec_helper"

describe CukeCrawler::Inventory do
  subject { inventory }
  let(:inventory) { CukeCrawler::Inventory.new }

  context "added to another Inventory" do
    subject { inventory + another_inventory }
    let(:another_inventory) { CukeCrawler::Inventory.new }

    it { is_expected.to be_an_instance_of(CukeCrawler::Inventory) }
  end
end
