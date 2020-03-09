require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @word = params[:word].upcase
    letters = params[:letters]

    if @word.chars.all? { |l| @word.count(l) <= letters.count(l) }
      if english_word?(@word)
        @answer = "Congratulations! #{@word} is a valid English word!"
      else
        @answer = "Sorry but #{@word} does not seem to be a valid Enlgish word..."
      end
    else
      @answer = "Sorry but #{@word} can't be built out of #{letters}"
    end
    @answer
  end
end
