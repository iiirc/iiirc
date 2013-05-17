class TransitionController < ApplicationController
  def show
    @uri = CGI.unescape(params[:to])

    respond_to do |format|
      format.html
    end
  end
end
