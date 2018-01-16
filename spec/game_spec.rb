require_relative '../lib/game'

RSpec.describe Game do

  context "#initialize" do
    it 'is initialized with a word 5-12 characters long as its solution' do
      game = Game.new
      expect(5..12).to cover game.solution.length
    end

    it 'chooses a different word each time' do
      game1 = Game.new
      game2 = Game.new
      expect(game1.solution).not_to eq(game2.solution)
    end

    it 'is initalized with an empty incorrect_guess_array' do
      game = Game.new
      expect(game.incorrect_guesses_array).to eq([])
    end

    it 'is initalized with 6 incorrect guesses allowed' do
      game = Game.new
      expect(game.incorrects_allowed).to eq(6)
    end

    it 'is initalized with a correct_guesses_array, which has as many blanks as the solution has characters' do
      game = Game.new

      expect(game.correct_guesses_array).to include("_")
      expect(game.correct_guesses_array.length).to eq(game.solution.length)
    end
  end

  context "#get_input" do
    it 'adds to correct_guesses_array if letter is in the solution' do
      game = Game.new
      #game.solution = 'foxes'
      allow(game).to receive(:solution).and_return('foxes')
      allow(game).to receive(:correct_guesses_array).and_return(["_", "_", "_", "_", "_"])
      game.get_input('e')

      expect(game.correct_guesses_array).to eq(["_", "_", "_", "e", "_"])
    end

    it 'adds to correct_guesses_array in correct spots if letter is in solution multiple times' do
      game = Game.new
      #game.solution = 'foxes'
      allow(game).to receive(:solution).and_return('copperfield')
      allow(game).to receive(:correct_guesses_array).and_return(["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"])
      game.get_input('p')

      expect(game.correct_guesses_array).to eq(["_", "_", "p", "p", "_", "_", "_", "_", "_", "_", "_"])
    end
  end

end
