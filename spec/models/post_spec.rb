require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
  	@blog = FactoryBot.create(:blog)
  end
end
