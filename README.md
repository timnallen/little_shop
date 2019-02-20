# Store64

'Store 64' is a fictitious e-commerce platform consisting of users, merchants, and admins. Site visitors can log in as a User, Merchant, or Admin. Users can add items to a cart, which they can ‘check out’ to create an order. Merchants can fulfill items in an order, and admins can access functionality of both users and merchants.

# Prerequisites

- Requires PostgreSQL database

# Getting Started

Clone the repo on your local machine from your terminal

    git clone https://github.com/plapicola/little_shop.git

Enter the newly created directory and run bundle install and bundle update

    cd little_shop
    bundle install
    bundle update

Create, migrate, and seed the database

    rake db:reset

Launch a local server with rails s

    rails s

Visit 'localhost:3000' in your internet browser

    (screenshot of welcome page)

Once you reach the welcome page you can access the site as a visitor or log in as a user, merchant or visitor. Login information is included in the 'Useful Features' section.

# Database Visualization

![Database Visualization](/database_schema.png?raw=true "Optional Title")

# Useful Features

You can log in as a default admin with the following credentials:

email: admin@gmail.com password: 'password'

Login information for various other users and merchants can be found in the db/seeds.rb file.

    (screnshot of db/seeds)

New users can be created through the 'Register' link in the navigation bar.

Admins can upgrade normal users to merchants or downgrade merchants to normal users via their respective profile or dashboard pages.

# How to Test

Store64 uses RSpec for testing. To run the full test suite, simply run 'rspec' from the terminal.

    rspec

Individual tests can be run by specifying the desired file path and line number. For example,

    rspec spec/models/item_spec.rb:65

will run the item model test that is found in that file on line 65.

# Built With

- Ruby on Rails Framework
- [Waffle.io](https://waffle.io/plapicola/little_shop)

# Authors

- [Tim Allen](https://github.com/timnallen)
- [Teresa Knowles](https://github.com/teresa-m-knowles)
- [Peter Lapicola](https://github.com/plapicola)
- [Chris Lewis](https://github.com/csvlewis)
