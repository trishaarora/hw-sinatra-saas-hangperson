class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :displayed
  # Get a word from remote "random word" service
  #game = HangpersonGame.new(self.get_random_word)
  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @displayed = ''
  end
  
  def guess(letter)
    if (/[a-zA-Z]/ =~ letter) ==0
      letter.downcase!
      if guesses.include? letter or wrong_guesses.include? letter 
        return false
      end
      if word.count(letter) >= 1
        @guesses = @guesses.concat(letter)
        return true
      else 
        if wrong_guesses.count(letter) < 1
          @wrong_guesses = @wrong_guesses.concat(letter)
        end
        return false
      end
    else
      raise ArgumentError
    end
  end

  
  def word_with_guesses
    wordList = word.split("")
    wordList.each do |x|
      if guesses.include? x 
        @displayed = @displayed.concat(x)
      else 
        @displayed = @displayed.concat("-")
      end
   end
   return @displayed
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7 and word_with_guesses != @word
      return :lose
    elsif @word == word_with_guesses
      return :win
    else
      return :play
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
