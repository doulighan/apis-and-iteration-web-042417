require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  results = []
  character_hash["results"].each do |characters|
    if characters["name"] == character
      characters["films"].each do |film|
        results << JSON.parse(RestClient.get("#{film}"))
      end
    end
  end
  results.uniq
end

def parse_character_movies(films_array)
  films_array.each_with_index do |films, i|
    puts "#{i + 1})"
    puts "Title: #{films["title"]}"
    puts "Release date: #{films["release_date"]}"
    puts "Director: #{films["director"]}"
  end


end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
