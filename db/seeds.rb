# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end


#############
#
# Books
#
#############
Book.delete_all
Book.create! name: 'The Shallows: What the Internet is Doing to Our Brains', released: true, premium: false
Book.create! name: 'In the Plex: How Google Thinks, Works, and Shapes Our Lives', released: true, premium: false
Book.create! name: 'Steve Jobs', released: true, premium: true
Book.create! name: 'My sample book', released: false, premium: false
Book.create! name: 'Another sample', released: false, premium: false
Book.create! name: 'Will never be released', released: false, premium: false

##################
#
# Admin users can see all books
# VIP users can see released books 
# Standard users can only see non-premium released books
#
##################
User.delete_all
# admin user
user = User.create! :name => "Admin", :email => "admin@example.org", :password => "changeme", :password_confirmation => "changeme"
user.add_role :admin

# VIP user
user = User.create! :name => "VIP", :email => "vip@example.org", :password => "changeme", :password_confirmation => "changeme"
user.add_role :VIP

# standard users
user = User.create! :name => "user1", :email => "user1@example.org", :password => "changeme", :password_confirmation => "changeme"
user.add_role :user
user = User.create! :name => "user2", :email => "user2@example.org", :password => "changeme", :password_confirmation => "changeme"
user.add_role :user
