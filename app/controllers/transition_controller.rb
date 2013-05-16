class TransitionController < ApplicationController
  def show
    @uri = params[:uri]

    respond_to do |format|
      format.html
    end
  end
end
