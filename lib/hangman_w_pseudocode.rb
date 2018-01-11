
# load in dictionary
# load_dictionary
#file = File.readlines("5desk.txt")



# randomly select a word between 5 and 12 characters
# select_word_from_dictionary    Game

def pick_random_word
  File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample#.split("")
end

x = pick_random_word
puts x


# display some sort of count so the player knows how many more incorrect guesses she has before the game ends
# calculate_guess_count
# display_guess_count          Game


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