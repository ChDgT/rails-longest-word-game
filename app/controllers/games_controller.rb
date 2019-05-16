require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:answer]
    @letters = params[:letters]
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) } == false
      @result = "Sorry but #{@word.upcase} can't be buid out of #{@letters}"
    elsif json['found'] == false
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulation ! #{@word.upcase} is a valid English word !"
    end
  end
end
