require 'uri'

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^There is at least a registered user$/ do
  @user = create(:user)
end

Given /^There are at least two registered user$/ do
  @user = create(:user)
  @user_aux = create(:user)
end

Given /^I am a registered user$/ do
  @user = create(:user)
  visit "login"
  fill_in "loginemail", :with => @user.email
  fill_in "loginpassword", :with => @user.password
  click_button('loginbutton').click
end

Given /^I am logged in$/ do
  visit "login"
  fill_in "loginemail", :with => @user.email
  fill_in "loginpassword", :with => @user.password
  click_button('loginbutton').click
end

Given /^I am not logged in$/ do
  page.driver.submit :delete, "/users/sign_out", {}
end

Given /^I am a banned user$/ do
  @user = create(:user, :banned => true)
  @user.banned = true
  visit "login"
  fill_in "loginemail", :with => @user.email
  fill_in "loginpassword", :with => @user.password
  click_button('loginbutton').click
end

Given /^There is at least one blog$/ do
  @blog = create(:blog, user: @user)
end

Given /^The blog has at least one post$/ do
  @post = create(:post, user: @user, blog: @blog)
end

Given /^I am the owner of the blog$/ do
	visit "login"
	fill_in "loginemail", :with => @user.email
	fill_in "loginpassword", :with => @user.password
	click_button('loginbutton').click

	expect(@user).to be == @blog.user
end

Given /^I am not the owner of the blog$/ do
	visit "login"
	fill_in "loginemail", :with => @user_aux.email
	fill_in "loginpassword", :with => @user_aux.password
	click_button('loginbutton').click

	expect(@user_aux).not_to be == @blog.user
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When ("I try to delete an account of others") do
  @user = create(:user, :email => "pippo@gmail.com")
  page.driver.submit :delete, "/users/#{@user.id}",{}
end

When /^I click (.*)/ do |element|
  click_on(element)
end

When /^I log in$/ do
  steps %Q{
    Given I am on the login page
    When I fill in "loginemail" with "simonestaffa96@gmail.com"
    And I fill in "loginpassword" with "staffa"
    And I press "loginbutton"
    Then I should be on the home page
    And I should see "Logout"
  }
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |file, field|
  attach_file(field, "#{Rails.root}/public/" + file)
end

And /^I should see the image$/ do
  expect(User.last.avatar_image).not_to be nil
end


When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  first(:link, link).click
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    expect(current_path).to be == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    expect(page).to have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end
