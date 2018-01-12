
# load in dictionary
# load_dictionary
#file = File.readlines("5desk.txt")



# randomly select a word between 5 and 12 characters
# select_word_from_dictionary    Game



# display some sort of count so the player knows how many more incorrect guesses she has before the game ends
# calculate_incorrect_guess_count
# display_incorrect_guess_count         Game

class Game
  attr_reader :solution, :correct_guesses_array
  def initialize
    @solution = pick_random_word
    @correct_guesses_array = make_blank_array([])
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
      display_correct_letter(letter_guess, correct_indices)
    else
      display_incorrect_letter(letter_guess)
    end
  end


  def display_correct_letter(letter, indices)
    #puts "DEVELOPMENT...displaying correct letter...#{correct_letter} "
    #need array with _s for solution.length+1
    #replace(gsub?) correct_letter with _ at indices revealed by correct_indices

    indices.each { |i| correct_guesses_array[i] = letter }
    #add correct_letter to correct_guesses_array
    p correct_guesses_array
  end

  def display_incorrect_letter(incorrect_letter)
    puts "DEVELOPMENT...displaying incorrect letter...#{incorrect_letter}"
    #need incorrect_guesses_array
    #add incorrect_letter to incorrect_guesses_array

    #can use incorrect_guesses_array along with correct_guesses_array to check for valid user input, add that logic to get_guess
  end

end

hangman = Game.new
puts hangman.solution

#empty_array = []
#blank_array = hangman.make_blank_array(empty_array)
#p blank_array
p hangman.correct_guesses_array


while true
  hangman.prompt_for_guess
  hangman.get_guess
  break if hangman.correct_guesses_array.include?('_') == false
end



#get letter guess from player
#prompt_for_guess
#clean_up_guess
#ensure_guess_is_valid
#check_guess

# display correct chosen letters in their respective places
# display_right_choices     Game


# display list of incorrectly chosen letters
# display_wrong_choices      Game



# Now implement the functionality where, at the start of any turn, instead of making a guess the player should
# also have the option to save the game. Remember what you learned about serializing objects… you can serialize your game class too!
# give_option_to_save
# save_game                Game


# When the program first loads, add in an option that allows you to open one of your saved games,
# which should jump you exactly back to where you were when you saved. Play on!
# give_option_to_load_saved_game
# load_saved_game          Game