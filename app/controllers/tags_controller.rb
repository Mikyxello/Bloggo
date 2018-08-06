class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all.order("taggings_count").reverse # TODO: where tag.taggins_count != 0
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end

  def mostcount
    @tags = ActsAsTaggableOn::Tag.all.order("taggings_count").reverse
  end

  def destroy
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_panel_index_path
  end

end
