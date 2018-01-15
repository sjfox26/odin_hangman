require "yaml"

class Game
  attr_reader :solution, :correct_guesses_array, :incorrect_guesses_array
  attr_accessor :incorrects_allowed

  def initialize
    @solution = pick_random_word
    @correct_guesses_array = make_blank_array([])
    @incorrect_guesses_array = []
    @incorrects_allowed = 6
  end

  def pick_random_word
    File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample#.split("")
  end

  def make_blank_array(input_array)
    i = 0
    while i < solution.length
      input_array << "_"
      i += 1
    end
    input_array
  end


  def prompt_for_guess
    puts "Type in your letter guess!"
  end

  def get_guess(guess = gets.chomp)
    check_guess(guess)
  end

  #https://stackoverflow.com/questions/1819540/return-index-of-all-occurrences-of-a-character-in-a-string-in-ruby
  def check_guess(letter_guess)
    correct_indices = (0 ... solution.length).find_all { |i| solution[i,1] == letter_guess }

    if correct_indices.length > 0
      insert_correct_letter(letter_guess, correct_indices)
    else
      insert_incorrect_letter(letter_guess)
    end
  end


  def insert_correct_letter(letter, indices)
    indices.each { |i| correct_guesses_array[i] = letter }
  end

  def insert_incorrect_letter(incorrect_letter)
    self.incorrects_allowed -= 1
    incorrect_guesses_array << incorrect_letter

    #can use incorrect_guesses_array along with correct_guesses_array to check for valid user input, add that logic to get_guess
  end

  def display_corrects
    p correct_guesses_array
  end

  def display_incorrects
    puts  "Not in the word: #{incorrect_guesses_array}"
    puts  "Incorrects allowed: #{incorrects_allowed}"
  end

  def to_s
    "In Game:\n #{@solution}, #{@correct_guesses_array}, #{@incorrect_guesses_array}, #{@incorrects_allowed}\n"
  end

  def save_game
    puts "Enter a name so you can retrieve your saved game later:"
    filename = gets.chomp.downcase
    Dir.mkdir("./saves") if !Dir.exist?("./saves")
    File.open("saves/#{filename}.yml", "w") do |file|
      file.write(YAML.dump(self))
    end
    puts "Game saved. The names of saved games can be located in the 'saves' folder"
  end

  def load_game
    puts "What name did you save your game as?"
    begin
      filename = gets.chomp.downcase
      game = YAML.load_file("saves/#{filename}.yml")
      game.play
    rescue
      puts "No saved files with that name. Try again:"
      retry
    end
  end


end


hangman = Game.new
puts hangman.solution

hangman.display_corrects
hangman.prompt_for_guess
hangman.get_guess
hangman.display_corrects
hangman.display_incorrects
hangman.prompt_for_guess
hangman.get_guess
hangman.display_corrects
hangman.display_incorrects
hangman.prompt_for_guess
hangman.get_guess
hangman.display_corrects
hangman.display_incorrects
hangman.prompt_for_guess
hangman.get_guess
hangman.display_corrects
hangman.display_incorrects

puts "now to serialize and save..."

hangman.save_game


hangman.load_game

#puts "Oh you want to continue playing?  Here's the game I saved for you"

#puts YAML::load(hangman)

#hangman.display_corrects
#hangman.prompt_for_guess
#hangman.get_guess

