class Game
  attr_reader :solution

  def initialize
    @solution = load_random_word
  end

  #https://github.com/JonathanYiv/hangman/blob/master/lib/gameboard.rb
  def load_random_word
    File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample#.split("")
  end
end

hangman = Game.new
puts hangman.solution