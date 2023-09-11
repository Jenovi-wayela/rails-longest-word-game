require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score

    @letters = params[:letters].split

    user_word = params[:word].upcase
    original_letters = params[:letters].split
    valid_word = user_word.chars.all? { |char| original_letters.include?(char) }
    if valid_word
      if valid_english_word?(user_word)
      flash[:notice] = "Congratulations! '#{user_word}' is a valid English word."
      else
        flash[:alert] = " Sorry, but'#{user_word}' does not seem to be a valid English word..."
      end
    else
      flash[:alert] = "Sorry, but '#{user_word}' can't be built out of '#{@letters}'"
    end

    # <%= link_to 'Play again', new_path %>
  end

  def valid_english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
