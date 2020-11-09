class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = []
    9.times do
      @letters << alphabet.sample
    end
  end

  def score
    
    search = params[:word].upcase
    given_letters = params[:letter_grid]
    url = "https://wagon-dictionary.herokuapp.com/#{search}"
    read_url = open(url).read
    json_result = JSON.parse(read_url)    
    
    def not_exceed_given_letters(search, given_letters)
      ok = true      
      search.each_char do |char|
        search.count(char) > given_letters.count(char) ? ok = false : ok = true
      end
      ok
    end
    
    def exists_in_dict?(json_result)
      json_result["found"] ? true : false
    end

    if !not_exceed_given_letters(search, given_letters)
      @response = "Sorry but #{search} cannot be built out of #{given_letters}"
    elsif !exists_in_dict?(json_result)
      @response = "Sorry but #{search} does not seem to be a valid English word"
    else
      @response = "Congratulations! #{search} is a valid English word!" 
    end 
    
  end
end
