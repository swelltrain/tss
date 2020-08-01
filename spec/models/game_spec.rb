# frozen_string_literal: true

RSpec.describe Game, type: :model do
  describe 'factory' do
    it "should have a valid factory" do
      expect(build(:game)).to be_valid
    end
  end
  describe '.sluggify' do
    it 'should downcase' do
      expect(Game.sluggify('This Game')).to eq('this game')
    end
  end

  describe '#name=' do
    it 'should also set slug' do
      g = Game.new
      g.name = 'This Is THe Game Name'
      expect(g.slug).not_to be_nil
    end
  end
end
