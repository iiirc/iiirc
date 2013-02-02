class TopController < ApplicationController
  def index
    @snippets = Snippet.all

    respond_to do |format|
      format.html
      format.json { render json: @snippets }
    end
  end
end
