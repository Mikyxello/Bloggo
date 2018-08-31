# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

#Generating Users
puts "Start seeding the database"
puts "Now generating Users..."

10.times do
	usernames = [Faker::Artist.name, Faker::LordOfTheRings.character, Faker::Hobbit.thorins_company, Faker::GameOfThrones.character, Faker::Pokemon.name, Faker::DragonBall.character, Faker::DcComics.hero, Faker::StarWars.character]

	User.create!(
		:email => 					Faker::Internet.unique.safe_email,
		:name =>					Faker::Name.first_name,
		:surname =>  				Faker::Name.last_name,
		:username =>  				usernames.sample,
		:birth_date =>  			Faker::Date.birthday(18, 60),
		:password => 				'password', 
		:password_confirmation =>	'password',
		:remote_avatar_image_url =>  Faker::Avatar.image
	)
end

user_count = User.count
users = User.all

puts "#{user_count} Users generated!"
puts "Now generating Blogs..."

# Generating Blogs

10.times do
	user_id = users.sample.id

	editors_num = Faker::Number.between(0, user_count)
	editors_id = ""
	if editors_num == 0
		editors_id = nil
	else
		editors_num.times do 
			new_editor = Faker::Number.unique.between(1, user_count)
			if new_editor != user_id
				editors_id = editors_id + new_editor.to_s + ","
			end
		end
		Faker::Number.unique.clear
	end

	Blog.create!(
		:name =>  				Faker::Company.unique.industry,
		:description =>  		Faker::Company.catch_phrase,
		:remote_profile_url =>  Faker::Avatar.image,
		:remote_header_url =>  	Faker::LoremFlickr.image("1280x720"),
		:user_id =>  			user_id,
		:editors => 			editors_id
	)
end

blog_count = Blog.count
blogs = Blog.all

puts "#{blog_count} Blogs generated!"
puts "Now generating Posts..."

# Generating Posts

30.times do
	tag_list = Faker::Number.between(1, 5).times.map { Faker::Internet.user_name(3..15) }
	subtitles = [Faker::Hipster.sentence(2),  Faker::Lorem.sentence(2)]
	blog_id = Faker::Number.between(1, blog_count)
	editors = Blog.find(blog_id).editors

	if (editors.nil?)
		user_id = Blog.find(blog_id).user_id
	else
		user_id_array = Blog.find(blog_id).editors.split(",").map(&:to_i) << Blog.find(blog_id).user_id
		user_id = user_id_array.sample
	end

	Post.create!(
		:title =>  			Faker::Hipster.paragraph_by_chars(Faker::Number.between(6, 40), false),
		:subtitle =>  		subtitles.sample,
		:content =>  		Faker::Lorem.paragraph(10), 
		:tag_list =>  		tag_list.join(',').gsub('"', '') ,
		:remote_file_url => Faker::LoremFlickr.image("600x500"),
		:blog_id =>			blog_id,
		:user_id => 		user_id
	)
end

post_count = Post.count
posts = Post.all

puts "#{post_count} Posts generated!"
puts "Now generating Comments..."

# Generating Comments

30.times do
	contents = [Faker::HarryPotter.quote, Faker::Hobbit.quote, Faker::Lebowski.quote, Faker::GreekPhilosophers.quote, Faker::RickAndMorty.quote, Faker::VForVendetta.quote, Faker::StarWars.quote]

	Comment.create!(
		:content => 	contents.sample,
		:user_id =>		users.sample.id,
		:post_id =>		posts.sample.id
	)
end

comment_count = Comment.count
comments = Comment.all

puts "#{comment_count} Comments generated!"
puts "Now generating Replies..."

# Generating Replies

10.times do
	contents = [Faker::HarryPotter.quote, Faker::Hobbit.quote, Faker::Lebowski.quote, Faker::GreekPhilosophers.quote, Faker::RickAndMorty.quote, Faker::VForVendetta.quote, Faker::StarWars.quote]
	parent = comments.sample

	Comment.create!(
		:content => 	contents.sample,
		:user_id =>		users.sample.id,
		:post_id =>		parent.post_id,
		:parent_id =>	parent.id
	)
end

puts "Replies generated!"
puts "Now generating Reactions..."

# Generating Reactions on Posts

posts.each do |post|
	like = Faker::Number.between(0, user_count)
	dislike = Faker::Number.between(0, user_count)

	like.times do
		post.upvote_by users.sample
	end

	dislike.times do
		post.downvote_by users.sample
	end
end

puts "Reactions generated!"
puts "Now generating Follows and Favorites..."

# Generating Follows on Blogs, Favorites Blogs and Favorites Post

users.each do |user|
	follows = Faker::Number.between(0, blog_count)
	favorites_blog = Faker::Number.between(0, blog_count)
	favorites_post = Faker::Number.between(0, blog_count)

	follows.times do
		user.follow(blogs.sample)
	end

	favorites_blog.times do
		user.favorite(blogs.sample)
	end

	favorites_post.times do
		user.favorite(posts.sample)
	end
end

puts "Follows and Favorites generated!"
puts "Finished to seed the database!"