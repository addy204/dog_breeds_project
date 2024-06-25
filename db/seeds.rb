require 'net/http'
require 'json'
require 'faker'

API_KEY = 'live_rkYy8hQWc1WTqBmqtRNq6RypLL4clHSuID3lxkPoxfwXcQEey2XKtuw1ZRYcMTFt'

# Helper method to fetch data from an API
def fetch_data_from_api(url)
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request['x-api-key'] = API_KEY
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end
  raise "Request failed with response code #{response.code}" unless response.is_a?(Net::HTTPSuccess)
  JSON.parse(response.body)
rescue JSON::ParserError => e
  puts "JSON parsing error: #{e.message}"
  return []
end

# Fetch Breeds from The Dog API
url = 'https://api.thedogapi.com/v1/breeds'
breeds_data = fetch_data_from_api(url)

breeds_data.each do |breed_data|
  breed_record = Breed.find_or_create_by!(name: breed_data['name']) do |b|
    b.sub_breeds = breed_data['bred_for']
  end

  # Fetch Images for the Breed
  image_url = "https://api.thedogapi.com/v1/images/search?limit=10&breed_ids=#{breed_data['id']}&api_key=#{API_KEY}"
  image_data = fetch_data_from_api(image_url)
  image_data.each do |image|
    BreedImage.find_or_create_by!(breed: breed_record, image_url: image['url'])
  end

  # Fetch Facts for the Breed (using breed temperament as fact)
  fact = breed_data['temperament'] || "No temperament information available."
  BreedFact.find_or_create_by!(breed: breed_record, fact: fact)
end

# Generate Fake Data for Owners
10.times do
  Owner.find_or_create_by!(name: Faker::Name.name)
end

# Generate Fake Data for DogShows
10.times do
  DogShow.find_or_create_by!(name: Faker::Lorem.word, date: Faker::Date.forward(days: 30))
end

# Associate Breeds with Owners and DogShows
Breed.all.each do |breed|
  breed.update(owner: Owner.all.sample) if breed.owner.nil?
  breed.dog_shows << DogShow.all.sample if breed.dog_shows.empty?
end

# Ensuring at least 200 rows are populated
# Calculate the number of rows already populated
total_rows = Breed.count + BreedImage.count + BreedFact.count + Owner.count + DogShow.count + BreedDogShow.count

# Populate additional rows if necessary
if total_rows < 200
  additional_breeds_needed = (200 - total_rows) / 3

  additional_breeds_needed.times do
    breed = Breed.find_or_create_by!(name: Faker::Creature::Dog.breed)
    BreedImage.find_or_create_by!(breed: breed, image_url: Faker::LoremFlickr.image(size: "640x480", search_terms: ['dog']))
    BreedFact.find_or_create_by!(breed: breed, fact: Faker::Lorem.sentence)
  end
end

# Ensure all owners have names
Owner.where(name: [nil, '']).find_each do |owner|
  owner.update(name: Faker::Name.name)
end

# Ensure all dog shows have names and dates
DogShow.where(name: [nil, '']).find_each do |show|
  show.update(name: Faker::Lorem.word)
end

DogShow.where(date: nil).find_each do |show|
  show.update(date: Faker::Date.forward(days: 30))
end

puts "Seeded breeds, images, facts, owners, and dog shows from APIs and Faker"
