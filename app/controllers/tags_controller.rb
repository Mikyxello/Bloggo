class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all.order("taggings_count").reverse
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end

  def mostcount
    @tags = ActsAsTaggableOn::Tag.all.order("taggings_count").reverse
  end

end
