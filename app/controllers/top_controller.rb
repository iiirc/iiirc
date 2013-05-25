class TopController < ApplicationController
  def index
    @snippets = Snippet.includes(:user, messages: [:stars]).published.date_desc.page(params[:page]).decorate

    respond_to do |format|
      format.html
      format.json { render json: @snippets }
    end
  end
end
