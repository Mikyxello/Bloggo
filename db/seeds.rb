# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

20.times do
	usernames = [Faker::Artist.name, Faker::LordOfTheRings.character, Faker::Hobbit.thorins_company, Faker::GameOfThrones.character, Faker::Pokemon.name ]

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

10.times do
	editor_id = Faker::Number.between(0, user_count)
	if editor_id == 0
		editor_id = nil
	end

	Blog.create!(
		:name =>  				Faker::Company.unique.industry,
		:description =>  		Faker::Company.catch_phrase,
		:remote_profile_url =>  Faker::Avatar.image,
		:remote_header_url =>  	Faker::LoremFlickr.image("1280x720"),
		:user_id =>  			users.sample.id,
		:editors => 			editor_id
	)
end

blog_count = Blog.count
blogs = Blog.all

70.times do
	tag_list = Faker::Number.between(1, 5).times.map { Faker::Internet.user_name(3..15) }
	subtitles = [Faker::Hipster.sentence(2),  Faker::Lorem.sentence(2)]
	blog_id = Faker::Number.between(1, blog_count)
	editors = Blog.find(blog_id).editors

	if (editors.nil?)
		user_id = Blog.find(blog_id).user_id
	else 
		user_id = [Blog.find(blog_id).user_id, Blog.find(blog_id).editors].sample
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

35.times do
	contents = [Faker::HarryPotter.quote, Faker::Hobbit.quote, Faker::Lebowski.quote, Faker::GreekPhilosophers.quote, Faker::RickAndMorty.quote, Faker::VForVendetta.quote]

	Comment.create!(
		:content => 	contents.sample,
		:user_id =>		users.sample.id,
		:post_id =>		posts.sample.id
	)
end

comments = Comment.all

20.times do
	contents = [Faker::HarryPotter.quote, Faker::Hobbit.quote, Faker::Lebowski.quote, Faker::GreekPhilosophers.quote, Faker::RickAndMorty.quote, Faker::VForVendetta.quote]
	parent = comments.sample

	Comment.create!(
		:content => 	contents.sample,
		:user_id =>		users.sample.id,
		:post_id =>		parent.post_id,
		:parent_id =>	parent.id
	)
end


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