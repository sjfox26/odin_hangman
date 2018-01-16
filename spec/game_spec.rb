require_relative '../lib/game'

RSpec.describe Game do

  context "#initialize" do
    it 'is initialized with a word 5-12 characters long as its solution' do
      hangman = Game.new
      expect(5..12).to cover hangman.solution.length
    end
  end
end