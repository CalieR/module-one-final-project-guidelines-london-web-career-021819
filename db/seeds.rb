
def get_heros_from_superhero_api(search_term)
  response = RestClient.get("https://www.superheroapi.com/api.php/109506093540004/search/#{search_term}")
  data = JSON.parse(response)
  data["results"]
end


def delete_null
  supers = get_heros_from_superhero_api("m")
  null_cards = supers.select do |card|
    card["powerstats"]["intelligence"] == "null" ||
    card["powerstats"]["strength"] == "null" ||
    card["powerstats"]["speed"] == "null" ||
    card["powerstats"]["durability"] == "null" ||
    card["powerstats"]["power"] == "null" ||
    card["powerstats"]["combat"] == "null"
   end
   no_null = supers - null_cards
end


delete_null.each do |sup|
  Card.create(name: sup["name"],
    intelligence: sup["powerstats"]["intelligence"],
    strength: sup["powerstats"]["strength"],
    speed: sup["powerstats"]["speed"],
    durability: sup["powerstats"]["durability"],
    power: sup["powerstats"]["power"],
    combat: sup["powerstats"]["combat"]
  )
end
