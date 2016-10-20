# Library class 
class Library
  attr_accessor :books, :orders, :readers, :authors
  attr_writer :data
  def initialize(books = nil, orders = nil, readers = nil, authors = nil)
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
  end

  def most_popular_book
    @data.orders.map(&:book).group_by(&:itself).values.max_by { :itself.length }.first.title
  end

  def often_takes_books
    @data.orders.map(&:reader).group_by(&:itself).values.max_by { :itself.length }.first.name
  end

  def how_order_most_popular
    @data.orders.map(&:book).group_by(&:title).values.first(3).map(&:length).sum
  end

  def read_data
    @data = YAML.load_file('data.yml')
  end

  def self::fill_random_data
    readers = []
    15.times do
      readers << Reader.new(Faker::Name.name, Faker::Internet.email, Faker::Address.city, Faker::Address.street_name, Faker::Address.building_number)
    end

      authors = []
      15.times do
        authors << Author.new(Faker::Name.name, Faker::Lorem.sentence)
      end

      books = []
      15.times do
        books << Book.new(Faker::Book.title, authors.sample)
      end

      orders = []
      15.times do
        orders << Order.new(books.sample, readers.sample, Faker::Date.backward(14))
      end

        library = Library.new(books, orders, readers, authors)

        File.open('data.yml', 'w') do |f|
          f.write library.to_yaml
        end
  end
end
