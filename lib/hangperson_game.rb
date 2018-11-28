class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def check_win_or_lose
    displayed = word_with_guesses
    return :win unless displayed.match('-')
    return :lose if @wrong_guesses.length == 7
    :play
  end 
  
  def word_with_guesses
    displayed = ''
    @word.chars.each do |character|
      displayed += character if @guesses.match(character)
      displayed += '-' if not @guesses.match(character)
    end
    displayed
  end
  
  def guess(character)
    raise ArgumentError if character == nil
    raise ArgumentError if character.empty?
    raise ArgumentError unless /[a-z]/i.match(character)
    
    downcased_character = character.downcase
    return false if @guesses.match(downcased_character)
    return false if @wrong_guesses.match(downcased_character)
    
    if word.match(downcased_character)
      @guesses += downcased_character
    else
      @wrong_guesses += downcased_character
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
