class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize()
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    sec_hash = secret_hash(@secret_word)
    sec_hash[char]
  end

  def secret_hash(word)
    hash = Hash.new {|h, k| h[k] = []}
    word.each_char.with_index { |c, i| hash[c] << i} 
    hash
  end

  def fill_indices(char, arr)
    arr.each {|idx| @guess_word[idx] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      p 'that has already been attempted'
      return false
    else
      @attempted_chars << char
      guess = get_matching_indices(char)
      guess.empty? ? @remaining_incorrect_guesses -= 1 : fill_indices(char, guess)
      return true
    end
  end

  def ask_user_for_guess
    p 'Enter a char: '
    user_input = gets.chomp
    return try_guess(user_input)
  end

  def win?
    p "WIN" if @guess_word.join('') == @secret_word
    @guess_word.join('') == @secret_word
  end

  def lose?
    p 'LOSE' if @remaining_incorrect_guesses == 0
    @remaining_incorrect_guesses == 0
  end

  def game_over?
    p @secret_word if win? || lose?
    win? || lose?
  end
end
