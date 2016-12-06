load 'modules/loader.rb'

class Library

  include Loader

  attr_accessor :books, :orders, :readers, :authors

  def initialize()
    @books, @orders, @readers, @authors = [],[],[],[]
    fill_random_data if File.zero?('data.yml')
  end

  def most_popular_book
    most_popular(:book, :title)
  end

  def often_takes_books
    puts most_popular(:reader, :name)
  end

  def how_order_most_popular(number)
    popular_book = most_popular(:book, :title, number)
    @orders.select{|order| popular_book.include?(order.book.title)}.uniq(&:reader).size
  end

  private
  def most_popular(type, field, number=1)
    @orders.map(&type).group_by(&:itself).sort{:itself.length}.first(number).flatten.map(&field).uniq
  end
end
