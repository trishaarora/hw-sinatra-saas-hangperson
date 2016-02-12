class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # Get a word from remote "random word" service
  #game = HangpersonGame.new(self.get_random_word)
  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    if (/[a-zA-Z]/ =~ letter) ==0
      letter.downcase!
      if guesses.include? letter or wrong_guesses.include? letter 
        return false
      end
      if @word.include? letter
        @guesses = @guesses.concat(letter)
        return true
      else 
        if !(@wrong_guesses.include? letter)
          @wrong_guesses = @wrong_guesses.concat(letter)
        end
        return false
      end
    else
      throw ArgumentError
    end
  end
  
  def word_with_guesses
    displayed = ""
    @word.each_char do |x|
      if @guesses.include? x 
        displayed = displayed.concat(x)
      else 
        displayed = displayed.concat("-")
      end
   end
   return displayed
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7 #and word_with_guesses != @word
      return :lose
    elsif @word == self.word_with_guesses # and @wrong_guesses.length <= 7
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
