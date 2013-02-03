class Api::SnippetsController < ApplicationController
  def show
    snippet = Snippet.find(params[:id])
    @html = render_to_string(partial: 'snippets/snippet', layout: false, locals: {snippet: snippet, current_user: nil})

    respond_to do |format|
      format.js
    end
  end
end
