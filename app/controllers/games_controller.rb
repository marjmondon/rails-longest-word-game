require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    if used_letters?(params[:answer].upcase, @letters.join(""))
      if english_word?(params[:answer])
        @answer = "c est un vrai mot"
      else
        @answer = "mot n existe pas dans le dico EN"
      end
    else
      @answer = "les lettres utilisees ne correspondent pas aux lettres offertes"
    end
  end

  def used_letters?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
