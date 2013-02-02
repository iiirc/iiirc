class TopController < ApplicationController
  def index
    @snippets = Snippet.all(order: 'id DESC')

    respond_to do |format|
      format.html
      format.json { render json: @snippets }
    end
  end
end
