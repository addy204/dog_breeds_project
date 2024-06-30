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

# Batch insert breeds
breed_records = breeds_data.map do |breed_data|
  {
    name: breed_data['name'],
    sub_breeds: breed_data['bred_for'],
    created_at: Time.now,
    updated_at: Time.now
  }
end

Breed.insert_all(breed_records)

# Fetch Facts for each breed
Breed.all.each do |breed_record|
  # Fetch Facts for the Breed (using breed temperament as fact)
  breed_data = breeds_data.find { |b| b['name'] == breed_record.name }
  fact = breed_data['temperament'] || "No temperament information available."
  BreedFact.create!(breed: breed_record, fact: fact)
end

# Generate Fake Data for Owners and DogShows
owners = 10.times.map { { name: Faker::Name.name, created_at: Time.now, updated_at: Time.now } }
Owner.insert_all(owners)

dog_shows = 10.times.map do
  {
    name: Faker::Lorem.word,
    date: Faker::Date.forward(days: 30),
    created_at: Time.now,
    updated_at: Time.now
  }
end
DogShow.insert_all(dog_shows)

# Associate Breeds with Owners and DogShows
Breed.all.each do |breed|
  breed.update(owner: Owner.all.sample) if breed.owner.nil?
  breed.dog_shows << DogShow.all.sample if breed.dog_shows.empty?
end

# Ensuring at least 200 rows are populated
# Calculate the number of rows already populated
total_rows = Breed.count + BreedFact.count + Owner.count + DogShow.count + BreedDogShow.count

# Populate additional rows if necessary
if total_rows < 200
  additional_breeds_needed = (200 - total_rows) / 3

  additional_breeds_needed.times do
    breed = Breed.create!(name: Faker::Creature::Dog.breed)
    BreedFact.create!(breed: breed, fact: Faker::Lorem.sentence)
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

puts "Seeded breeds, facts, owners, and dog shows from APIs and Faker"
