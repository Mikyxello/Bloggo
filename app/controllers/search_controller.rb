class SearchController < ApplicationController

  def search_params
    params.require(:search).permit(:keyword)
  end
end
