class HomeController < ApplicationController

  def index
    @blogs = if params[:blog]
			         Blog.where('name LIKE ?',"%#{params[:blog]}%").last(5)
		         else
              Blog.last(5)
		              end
    @most_viewed = Blog.order('impressions_count DESC').last(5)
    @posts = Post.order(:cached_weighted_average => :desc, :cached_votes_total => :desc, :impressions_count => :asc).first(5)
    @tags = ActsAsTaggableOn::Tag.most_used.order("taggings_count").first(5)
  end


end
