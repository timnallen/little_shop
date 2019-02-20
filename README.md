# Store64

“Store 64” is a fictitious e-commerce platform consisting of users, merchants, and admins. Users can add items to a cart, which they can ‘check out’ to create an order. Merchants can fulfill their items in an order, and admins can access functionality of both users and merchants.

#Prerequisites

- Requires PostgreSQL database

#Getting Started

Clone the repo on your local machine from your terminal.

    git clone https://github.com/plapicola/little_shop.git

Run bundle install and bundle update.

    bundle install
    bundle update

Create, migrate, and seed the database.

    rake db:reset

Launch a local server with rails s.

    rails s

Visit localhost:3000 in your internet browser.

    (screenshot of welcome page)

#Useful Features

You can log in as a default admin with the credentials email: admin@gmail.com password: 'password'.

Login information for various users and merchants can be found in the db/seeds.rb file.

#How to Test

Store64 uses RSpec for testing. To run the full test suite, simply run 'rspec' from the terminal.

    rspec

Individual tests can be run by specifying the desired file path and line number. For example,

    rspec spec/models/item_spec.rb:65

will run the item model test that is found in that file on line 65.

#Built With

- Ruby on Rails Framework
- [Waffle.io](https://waffle.io/plapicola/little_shop)

#Authors

[Tim Allen](https://github.com/timnallen)
[Teresa Knowles](https://github.com/teresa-m-knowles)
[Peter Lapicola](https://github.com/plapicola)
[Chris Lewis](https://github.com/csvlewis)
