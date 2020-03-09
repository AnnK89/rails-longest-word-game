require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    session[:score] ||= 0
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    word = params[:word]
    letters = params[:letters].downcase

    if word.chars.all? { |l| word.count(l) <= letters.count(l) }
      answer = "Sorry but #{word} does not seem to be a valid English word"
      if english_word?(word)
        answer = "Congratulations! #{word} is a valid English word!"
        score = word.length**2
        session[:score] += score
      end
    else
      answer = "Sorry but #{word} can't be built out of #{letters}"
    end

    @output = [answer, session[:score]]
  end

  def reset
    reset_session
    redirect_to new_path
  end
end
