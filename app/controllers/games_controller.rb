require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = random_letters
  end

  def score
    @word = params[:word]
    @result = display_message
  end
  
  private

  def random_letters 
    Array.new(10) {('a'..'z').to_a.sample}
  end

  def check_word
    @word.split('').select do |letter|
      params[:letters].split(' ').include?(letter)
    end.join
  end

  def fetch_data
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)["found"]
  end

  def display_message
    if fetch_data == true
      if check_word == @word
        'Your word exist'
      else
        'Your word exist in the dictionary but not does not include in the List'
      end
    else
      'That word does not exist'
    end
  end
end




