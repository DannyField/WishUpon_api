class KeywordsController < ApplicationController
  def index
    keywords = Keyword.all
    render json: { keywords: keywords }
  end
end
