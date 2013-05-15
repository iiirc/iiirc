class TopController < ApplicationController
  def index
    @snippets = Snippet.published.date_desc.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @snippets }
    end
  end
end
