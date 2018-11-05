class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(12)
  end

  def valid?(attempt, original)
    result = true
    pool = original.split('')
    attempt.upcase.chars.each do |our_char|
      if pool.include?(our_char)
        pool.delete_at(pool.index(our_char))
      else
        result = false
      end
    end
    result
  end

  def english(attempt)
    url = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
    doc = JSON.parse(url)
    doc["found"]
  end

  def score
    @attempt = params[:attempt]
    @original = params[:original]
    url = open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
    doc = JSON.parse(url)
    @english = doc["found"]
    @is_valid = valid?(@attempt, @original)
  end
end
