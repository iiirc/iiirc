class TopController < ApplicationController
  def index
    @organizations = Organization.has_snippets
    @snippets = Snippet.with_assoc.published.date_desc.page(params[:page]).decorate

    respond_to do |format|
      format.html
      format.json { render json: @snippets }
    end
  end
end
