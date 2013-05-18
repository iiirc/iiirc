class Api::SnippetsController < ApplicationController
  def show
    snippet = Snippet.find_by_hash_id(params[:id])
    if snippet.blank?
      snippet = Snippet.find_by_id(params[:id])
      return render_not_found unless snippet.try(:published?)
    end
    @html = render_to_string(partial: 'snippets/snippet', layout: false, locals: {snippet: snippet, current_user: nil})

    respond_to do |format|
      format.js
    end
  end
end
