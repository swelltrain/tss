require 'rails_helper'

describe Game, '.sluggify', type: :model do
  it 'should downcase' do
    expect(Game.sluggify('This Game')).to eq('this game')
  end
end

RSpec.describe Game, 'name=', type: :model do
  it 'should also set slug' do
    g = Game.new
    g.name = 'This Is THe Game Name'
    expect(g.slug).not_to be_nil
  end
end
