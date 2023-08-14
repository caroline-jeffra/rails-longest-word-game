class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @result_statement = ''
    @strong = ''
    @prefix = ''
    grid = params[:letter_set].split(' ')
    word = params[:word].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = HTTParty.get(url)
    if word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
      if response['found'] == true
        @strong = 'Congratulations!'
        @result_statement = " #{word} is a valid English word."
      else
        @prefix = 'Sorry but '
        @strong = word.to_s
        @result_statement = ' does not seem to be a valid English word...'
      end
    else
      @prefix = 'Sorry but '
      @strong = word
      @result_statement = " can't be built out of #{grid.join(', ')}"
    end
  end
end
