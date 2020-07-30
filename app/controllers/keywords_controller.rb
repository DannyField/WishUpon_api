class KeywordsController < ApplicationController
  # the index function will show all keywords 
  # render the json to the front end
  def index
    keywords = Keyword.all
    render json: { keywords: keywords }
  end
end
