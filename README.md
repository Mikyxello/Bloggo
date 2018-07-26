# Bloggo

Bloggo is a social network Web App that allows its user to create "Bloggos" for creating content (Posts) and receive feedbacks from other users with Comments and Reactions (like or dislike). Also provide some stats of the social network, like the most used Tags on the entire database and the most upvoted Posts.  

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Needed `ruby-2.5.1` and the gem `rails-5.2.0` for running this project

### Installing

Just clone the repository with `git clone https://github.com/Mikyxello/Bloggo.git`, install all needed gems with 

```
bundle install
```
and execute the server with

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

## Running the tests

For running `rspec` test user 

```
bundle exec rspec
```

## Built With

* [Ruby on Rails](https://rubyonrails.org/) - The web framework used for backend
* [Bootstrap](https://getbootstrap.com/) - Frontend library
* [Unsplash](https://unsplash.com/) - External API for letting users get free images to use
* [Photoeditor](https://www.photoeditorsdk.com/) - External API for letting users modify images
* [Agor](https://www.open-agora.com/en/products/api) - External API for letting users make polls
* [FroalaEditor](https://www.froala.com/wysiwyg-editor) - External API for personalized text area

## Authors

* **Michele Anselmi** - *Post and Comment handling* - [Mikyxello](https://github.com/Mikyxello)
* **Simone Staffa** - *Login and Registration handling* - [lim996](https://github.com/lim996)
* **Andrea Misuraca** - *Profile and Blog handling* - [andreamisu](https://github.com/andreamisu)
* **Simone Silvestri** - *Bloggo Search and API interaction* - [mrPsycox](https://github.com/mrPsycox)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the GNU License - see the [LICENSE.md](LICENSE.md) file for details