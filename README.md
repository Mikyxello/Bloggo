# Bloggo

Bloggo is a social network Web App that allows its user to create blogs for creating content (posts) and receive feedbacks from other users with comments and reactions (like or dislike). Also provide some stats of the social network, like the most used Tags on the entire database and the most upvoted Posts. Users can also follow their favorites blogs for receiving notifications about new posts in these blogs. A user that creates a blog is called "Bloggoer", and can appoint "Editor" other users, who can create content in the blog they are editor of.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

Needed `ruby-2.5.1` and the gem `rails-5.2.1` for running this project

For installing Ruby see https://www.ruby-lang.org/en/documentation/installation/

### Installing

Just clone the repository with `git clone https://github.com/Mikyxello/Bloggo.git`, install all needed gems with 

```
bundle install
```
Run database's migrations with

```
rake db:migrate
```

Then setup the database (it will take a few minutes) with

```
rake db:setup
```

And run the server with

```
rails server
```

It will show the following output
```
=> Booting Puma
=> Rails 5.2.0 application starting in development 
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.5.1-p57), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```
Then you can try to navigate using your browser using the URL `localhost:3000/`

And stop it anytime with `Ctrl-C`

## Running the tests

For running `cucumber` tests use

```
rake cucumber
```

For running `rspec` tests use

```
bundle exec rspec
```

or just `rspec`

## Built With

* [Ruby on Rails](https://rubyonrails.org/) - The web framework used for backend
* [Bootstrap](https://getbootstrap.com/) - Frontend library (CSS and JS)
* [Unsplash](https://unsplash.com/) - External API for letting users get free images to use
* [Photoeditor](https://www.photoeditorsdk.com/) - External API for letting users modify images
* [Agor](https://www.open-agora.com/en/products/api) - External API for letting users make polls
* [ParallelDots](https://www.paralleldots.com/) - External API for generate automatic tags

## Authors

* **Michele Anselmi** - *Post and Comment handling* - [Mikyxello](https://github.com/Mikyxello)
* **Simone Staffa** - *Login and Registration handling* - [lim996](https://github.com/lim996)
* **Andrea Misuraca** - *Profile and Blog handling* - [andreamisu](https://github.com/andreamisu)
* **Simone Silvestri** - *Bloggo Search and API interaction* - [mrPsycox](https://github.com/mrPsycox)

See also the list of [contributors](https://github.com/Mikyxello/Bloggo/contributors) who participated in this project.

## License

This project is licensed under the GNU License - see the [LICENSE.md](LICENSE.md) file for details
