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

  context "#check_for_correct_indices" do
    it 'returns the correct index of included letter when one occurence' do
      game = Game.new
      allow(game).to receive(:solution).and_return('copperfield')

      expect(game.check_for_correct_indices('r')).to eq([5])
    end

    it 'returns the correct indices of included letter when multiple occurences' do
      game = Game.new
      allow(game).to receive(:solution).and_return('traddles')

      expect(game.check_for_correct_indices('d')).to eq([3, 4])
    end

    it 'returns the correct indices of included letter when lots of occurences' do
      game = Game.new
      allow(game).to receive(:solution).and_return('mississippi')

      expect(game.check_for_correct_indices('i')).to eq([1, 4, 7, 10])
    end
  end

  context "#get_input" do
    it 'results in correct_guesses_array being correctly updated if letter is in solution ' do
      game = Game.new
      allow(game).to receive(:solution).and_return('mississippi')
      allow(game).to receive(:correct_guesses_array).and_return(["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"])

      game.get_input('s')
      expect(game.correct_guesses_array).to eq(["_", "_", "s", "s", "_", "s", "s", "_", "_", "_", "_"])
    end

    it 'results in incorrect_guesses_array being correctly updated if letter is in solution ' do
      game = Game.new
      allow(game).to receive(:solution).and_return('mississippi')

      game.get_input('x')
      expect(game.incorrect_guesses_array).to eq(["x"])
    end

    it 'routes to save if user types in save ' do
      game = Game.new

      expect(game).to receive(:save_game)
      game.get_input('save')
    end

    it 'routes to load if user types in load ' do
      game = Game.new

      expect(game).to receive(:load_game)
      game.get_input('load')
    end
  end


  #save

  #load
  # context "#load" do
  #   it 'loads a saved game' do
  #     game = Game.new
  #     allow(game).to receive(:solution).and_return('mississippi')
  #     allow(game).to receive(:correct_guesses_array).and_return(["_", "_", "s", "s", "_", "s", "s", "_", "_", "_", "_"])
  #
  #     filepath = "saves/test44.yml"
  #
  #     parsed_yaml = {
  #         "incorrect_guesses_array": [],
  #         "correct_guesses_array": [
  #             "_",
  #             "_",
  #             "s",
  #             "s",
  #             "_",
  #             "s",
  #             "s",
  #             "_",
  #             "_",
  #             "_",
  #             "_"
  #         ],
  #         "solution": "mississippi",
  #         "incorrects_allowed": 6
  #     }
  #
  #     allow(YAML).to receive(:load_file).with(filepath).and_return(parsed_yaml)
  #     allow(YAML).to receive(:file)
  #
  #     expect(game.load_game).to eq(parsed_yaml)
  #
  #   end
  # end

end
