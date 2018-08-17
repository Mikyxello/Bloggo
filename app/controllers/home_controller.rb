class HomeController < ApplicationController

  def index
    @blogs = if params[:blog]
			         Blog.where('name LIKE ?',"%#{params[:blog]}%").last(8)
		         else
              Blog.last(5)
		        end
    @posts = Post.order(:cached_weighted_average => :desc, :cached_votes_total => :desc, :impressions_count => :asc).first(3)
    @tags = ActsAsTaggableOn::Tag.most_used.order("taggings_count").first(5)
    if user_signed_in?
      @updated_posts = Array.new
      @most_viewed = current_user.following_by_type('Blog').order(:updated_at).last(5)
      @most_viewed.each do |bl|
        @updated_posts << bl.posts.order(:created_at).last(1).shift
      end
    else
      @most_viewed = Blog.order('impressions_count DESC').last(5)
    end
  end

end
