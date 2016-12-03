require 'require_all'
require 'active_support/all'
require 'yaml'
require 'faker'
require 'pp'
require_all 'classes'
require_all 'modules'

library = Library.new
library.read_data

p 'Most often takes the book'
puts library.often_takes_books
p 'Most popular book'
puts library.most_popular_book
p 'Peoples ordered one of the three most popular books'
puts library.how_order_most_popular 3
