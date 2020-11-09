class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = []
    9.times do
      @letters << alphabet.sample
    end
  end

  def score
  end
end
