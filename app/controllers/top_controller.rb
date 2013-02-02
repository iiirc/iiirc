class TopController < ApplicationController
  def index
    @snippets = Snippet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snippets }
    end
  end
end
