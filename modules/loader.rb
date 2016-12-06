module Loader

  def fill_random_data
  15.times do
      self.readers << Reader.new(Faker::Name.name, Faker::Internet.email, Faker::Address.city, Faker::Address.street_name, Faker::Address.building_number)
      self.authors << Author.new(Faker::Name.name, Faker::Lorem.sentence)
      self.books << Book.new(Faker::Book.title, self.authors.sample)
      self.orders << Order.new(self.books.sample, self.readers.sample, Faker::Date.backward(14))
    end
    save_data
  end

  def save_data
    File.open('data.yml', 'w') do |f|
      f.write self.to_yaml
    end
  end

  def read_data
    data = YAML.load_file('data.yml')
    %w(books readers authors orders).each{|obj| self.instance_variable_set(:"@#{obj}", data.instance_variable_get("@#{obj}"))}
  end
end
