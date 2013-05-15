class TopController < ApplicationController
  def index
    @snippets = Snippet.published.date_desc.decorate

    respond_to do |format|
      format.html
      format.json { render json: @snippets }
    end
  end
end
