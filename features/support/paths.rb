module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #

  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the search\s?page$/
      search_index_path

    when /^the blog page$/
      blog_path(Blog.take)

    when /^the new post page$/
      new_blog_post_path(@blog)

    when /^the post page$/
      if (@post.nil?)
        blog_post_path(@blog, Post.take)
      else
        blog_post_path(@blog, @post)
      end

    when /^the post edit page$/
      edit_blog_post_path(@blog, Post.take)

    when /^the sign up page$/
      '/users/sign_up'

    when /^my profile page$/
      '/welcome/profile'

    when /^the login page$/
      '/users/sign_in'

    when /^my insertions page$/
      '/properties'

    when /^the last insertion page$/
      property_path(Property.last)

    when /^conversations page$/
      '/conversations'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
