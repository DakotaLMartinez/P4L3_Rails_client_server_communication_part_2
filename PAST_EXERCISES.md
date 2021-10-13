# Phase 4 Exercises

NOTE: This rails application will be the one you use for every check for understanding going forward. If you are unable to complete this check for understanding, reach out to an instructor after lecture for help. 

In your breakout rooms one person should share their screen and walk through the activity. Everyone should be helping the presenter or following along. If you get stuck on a bug, switch to another student's screen to finish the activity and reach out to the lecturer or instructor for assistance after the lecture.


## Lesson 1

### Instructions




1. Create a new rails application for our reading list application. 
`rails new reading_list_api --api --minimal -T`
Note: Do not forget the --api! The rails application will not be configured correctly if you do! If you forget it, delete the application and re-create it. 
2. Configure cors by uncommenting the gem ‘rack-cors’ and going to config>initializers> cors.rb
Uncomment the following and replace `'example.com'` with `*`
```rb 
Rails.application.config.middleware.insert_before 0, Rack::Cors do
   allow do
     origins '*'

     resource '*',
       headers: :any,
       methods: [:get, :post, :put, :patch, :delete, :options, :head]
   end
 end
```
3. Create the following migrations for reading_list
![Reading List ERD](https://res.cloudinary.com/dnocv6uwb/image/upload/v1632087131/reading-list-erd_hgmw9t.png)
Note: you do not need to write the tables yourself. There is a way to automatically generate the table with the corresponding columns using rails generators

4. Go to Models and add the 6 association macros necessary for many-to-many between users and books.. 
5. In the rails console OR in seeds create seeds for user and books and test your relationships. (You'll want to create books that are related to users, try checking out the [has_many](https://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_many) docs for examples). Feel free to use these if you like:
```
user_1 = User.create(
  username: 'tester1',
  email: 'test@test.com',
  bio: 'testing is my life!'
)
user_2 = User.create(
  username: 'tester2',
  email: 'testing@test.com',
  bio: 'to test or not to test, that is the question'
)

blink = user_1.books.create(
  title: 'Blink',
  author: 'Malcolmn Gladwell',
  description: "Blink is a book about how we think without thinking, about choices that seem to be made in an instant-in the blink of an eye-that actually aren't as simple as they seem. ... Now, in Blink, he revolutionizes the way we understand the world within.",
  cover_image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631945315/ulnbyvuxti0mklh4ya46.jpg"
)

the_way_of_kings = user_1.books.create(
  title: 'The Way of Kings', 
  author: 'Brandon Sanderson',
  description: "The Way of Kings is an epic fantasy novel written by American author Brandon Sanderson and the first book in The Stormlight Archive series. The novel was published on August 31, 2010, by Tor Books. The Way of Kings consists of one prelude, one prologue, 75 chapters, an epilogue and 9 interludes. It was followed by Words of Radiance in 2014, Oathbringer in 2017 and Rhythm of War in 2020. A leatherbound edition is scheduled to be released in 2021.",
  cover_image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631946131/menvv6ioanlrbh0qi35d.jpg"
)

name_of_the_wind = user_1.books.create(
  title: 'The Name of the Wind', 
  author: 'Patrick Rothfuss',
  description: "The Kingkiller Chronicle tells the life story of a man named Kvothe. In the present day, Kvothe is a rural innkeeper, living under a pseudonym. In the past, he was a wandering trouper and musician who grew to be a notorious arcanist (or wizard), known as the infamous \"Kingkiller\".

The series is framed as the transcription of his three-day-long oral autobiography, where he \"trouped, traveled, loved, lost, trusted and was betrayed.\" Present-day \"interludes\" concern his life as an innkeeper, with each present day depicted in a separate book.

The series is a secondary world fantasy; the setting is named Temerant. It has its own magic system, mixing alchemy, sympathetic magic, sygaldry (a form of runic magic combined with medieval engineering), and naming (a type of magic that allows the user to command the classical elements and objects), plus others.",
  cover_image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631946293/220px-TheNameoftheWind_cover_jq2xut.jpg"

```
6. In `config/routes.rb` add an index and show route for books
7. In the Books controller add an index action that renders all of the books in json. Make a show action that renders 1 book’s information given the id (as a bonus, try to include the book’s users as well. 
8. Run your rails server and go to the browser (or use postman) to check that your json is being rendered for both routes

---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---

### Solutions

#### Create the new application
```bash
rails new reading_list_api --api --minimal -T
```

#### Uncomment rack-cors in Gemfile

```rb
# Gemfile
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

```

#### Configure CORS to allow requests from anywhere
```rb
# config/intializers/cors.rb
# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

#### Create Models/Migrations/Routes


```rb
rails g model User username email bio:text
```

```rb
rails g resource Book title author description:text cover_image_url
```

```rb
rails g model UserBook user:belongs_to book:belongs_to read:boolean
```

```bash
rails db:migrate
```

#### Add Relationships

```rb
class Book < ApplicationRecord
  has_many :user_books
  has_many :readers, through: :user_books, source: :user
end
```

```rb
class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books
end

```

#### Add Seed Data

```rb
# db/seeds.rb
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create(
  username: 'tester1',
  email: 'test@test.com',
  bio: 'testing is my life!'
)
user_2 = User.create(
  username: 'tester2',
  email: 'testing@test.com',
  bio: 'to test or not to test, that is the question'
)

blink = user_1.books.create(
  title: 'Blink',
  author: 'Malcolmn Gladwell',
  description: "Blink is a book about how we think without thinking, about choices that seem to be made in an instant-in the blink of an eye-that actually aren't as simple as they seem. ... Now, in Blink, he revolutionizes the way we understand the world within.",
  cover_image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631945315/ulnbyvuxti0mklh4ya46.jpg"
)

the_way_of_kings = user_1.books.create(
  title: 'The Way of Kings', 
  author: 'Brandon Sanderson',
  description: "The Way of Kings is an epic fantasy novel written by American author Brandon Sanderson and the first book in The Stormlight Archive series. The novel was published on August 31, 2010, by Tor Books. The Way of Kings consists of one prelude, one prologue, 75 chapters, an epilogue and 9 interludes. It was followed by Words of Radiance in 2014, Oathbringer in 2017 and Rhythm of War in 2020. A leatherbound edition is scheduled to be released in 2021.",
  cover_image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631946131/menvv6ioanlrbh0qi35d.jpg"
)

name_of_the_wind = user_1.books.create(
  title: 'The Name of the Wind', 
  author: 'Patrick Rothfuss',
  description: "The Kingkiller Chronicle tells the life story of a man named Kvothe. In the present day, Kvothe is a rural innkeeper, living under a pseudonym. In the past, he was a wandering trouper and musician who grew to be a notorious arcanist (or wizard), known as the infamous \"Kingkiller\".

The series is framed as the transcription of his three-day-long oral autobiography, where he \"trouped, traveled, loved, lost, trusted and was betrayed.\" Present-day \"interludes\" concern his life as an innkeeper, with each present day depicted in a separate book.

The series is a secondary world fantasy; the setting is named Temerant. It has its own magic system, mixing alchemy, sympathetic magic, sygaldry (a form of runic magic combined with medieval engineering), and naming (a type of magic that allows the user to command the classical elements and objects), plus others.",
  cover_image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631946293/220px-TheNameoftheWind_cover_jq2xut.jpg"
)

```

```bash
rails db:seed
```

#### Restrict routes to Index and Show

```rb
# config/routes.rb
Rails.application.routes.draw do
  resources :books, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

```rb
# app/controllers/books_controller.rb
class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def show
    render json: Book.find(params[:id]), include: [:readers]
  end
end

```

#### Boot server and test routes with Postman

```bash
rails s
```

Open up postman and try out these requests:

- GET 'http://localhost:3000/books'
- GET 'http://localhost:3000/books/1'

