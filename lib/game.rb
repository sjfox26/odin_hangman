require "yaml"

class Game
  attr_reader :incorrect_guesses_array
  attr_accessor :incorrects_allowed, :solution, :correct_guesses_array

  def initialize
    @solution = pick_random_word
    @correct_guesses_array = make_blanks_array([])
    @incorrect_guesses_array = []
    @incorrects_allowed = 6
  end

  def pick_random_word
    File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample#.split("")
  end

  def make_blanks_array(input_array)
    i = 0
    while i < solution.length
      input_array << "_"
      i += 1
    end
    input_array
  end

  def welcome
    puts "Welcome to hangman!  At any point, you can type 'save' to save your current game, or 'load' to load a previously saved game."
  end

  def prompt_for_input
    puts "Type in your letter guess!"
  end

  def get_input(input = gets.chomp)
    if input == 'save'
      save_game
    elsif input == 'load'
      load_game
    else
      check_guess(input)
    end
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
    p correct_guesses_array.join(' ')
  end

  def display_incorrects
    puts  "Not in the word: #{incorrect_guesses_array}"
    puts  "Incorrects allowed: #{incorrects_allowed}"
  end


  def save_game
    puts "Enter a name so you can retrieve your saved game later:"
    filename = gets.chomp.downcase
    Dir.mkdir("./saves") if !Dir.exist?("./saves")
    File.open("saves/#{filename}.yml", "w") do |file|
      file.write(YAML.dump(self))
    end
    puts "Game saved. The names of saved games can be located in the 'saves' folder"
    exit
  end


  def load_game
    puts "What name did you use to save your game?"
    retries ||= 0
    begin
      filename = gets.chomp.downcase
      new_game = YAML.load_file("saves/#{filename}.yml")
      new_game.play
    rescue
      puts "No saved files with that name. After two unsuccessful attempts, you will be redirected to the active game."
      retry if (retries += 1) < 2
    end
  end

  def display_saved_list
    puts "Here is the current list of saved games:"
    Dir.foreach('./saves') do |save_name|
      next if save_name == '.' or save_name == '..'
      name_no_dot_yml = save_name.sub /\.[^.]+\z/, ""
      puts "#{name_no_dot_yml}"
    end
  end

  def check_for_game_end
    if correct_guesses_array.include?('_') == false
      display_corrects
      puts "You got it! You're a real wordsmith!"
      exit
    elsif incorrects_allowed == 0
      puts "Sorry! It's a hangman!"
      puts "The word was #{solution}!"
      exit
    end
  end

  def play
    #puts "at any point, type 'save' to save the game at current point"  / INSTRUCTIONS
    #implement 'save' logic
    welcome

    while true
      display_corrects
      display_incorrects
      prompt_for_input
      get_input
      check_for_game_end
    end
  end


end


hangman = Game.new
#hangman.display_saved_list
puts hangman.solution

hangman.play
