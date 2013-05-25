# -*- coding: utf-8 -*-
class SnippetsController < ApplicationController
  before_action :set_snippet, only: %w(show destroy)

  # GET /snippets
  # GET /snippets.json
  # GET /snippets.atom
  def index
    @snippets = Snippet.includes(messages: [:stars]).published.date_desc.decorate

    respond_to do |format|
      format.html # index.html.slim
      format.json { render json: @snippets }
      format.atom { render atom: @snippets }
    end
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @snippet = @snippet.decorate

    respond_to do |format|
      format.html # show.html.slim
      format.json { render json: @snippet }
    end
  end

  # GET /snippets/new
  # GET /snippets/new.json
  def new
    @snippet = Snippet.new.decorate

    respond_to do |format|
      format.html # new.html.slim
      format.json { render json: @snippet }
    end
  end

  # POST /snippets
  def create
    return render_access_denied if current_user.blank?
    content = params[:content].strip
    snippet = current_user.snippets.build(snippet_params)
    snippet.published = params[:commit] == 'public'

    content.each_line do |raw_content|
      snippet.messages.build(raw_content: raw_content.chomp)
    end

    respond_to do |format|
      if snippet.save
        redirect_to = snippet.published? ? snippet : "/snippets/#{snippet.hash_id}"
        format.html { redirect_to redirect_to, notice: 'Snippet was successfully created.' }
      else
        @snippet = snippet.decorate
        format.html { render action: "new" }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Snippet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_snippet
    @snippet = Snippet.includes(messages: [:stars]).find_by_hash_id(params[:id])

    if @snippet.blank?
      @snippet = Snippet.includes(messages: [:stars]).find_by_id(params[:id])
      return render_not_found unless @snippet.try(:published?)
    end
  end

  def snippet_params
    params.require(:snippet).permit(:title)
  end
end
