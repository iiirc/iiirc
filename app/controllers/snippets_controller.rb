# -*- coding: utf-8 -*-
class SnippetsController < ApplicationController
  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.published

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snippets }
      format.atom { render atom: @snippets }
    end
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @snippet = Snippet.find_by_hash_id(params[:id])
    if @snippet.blank?
      @snippet = Snippet.find_by_id(params[:id])
      return render status: :not_found, text: "404 not found" unless @snippet.try(:published?)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @snippet }
    end
  end

  # GET /snippets/new
  # GET /snippets/new.json
  def new
    @snippet = Snippet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @snippet }
    end
  end

  # POST /snippets
  def create
    return render status: :forbidden, text: "Hey! Forbidden fruit :S" if current_user.blank?
    @content = params[:content].strip
    @snippet = current_user.snippets.build(params[:snippet])
    @snippet.title = Time.now.to_s if @snippet.title.blank? # これも汚くてすません...
    @snippet.published = params[:commit] != "Secret post!"  # あとでもうちょっとちゃんとします...

    @content.each_line.collect do |raw_content|
      @snippet.messages.build(raw_content: raw_content.chomp)
    end
    @snippet.hash_id = Digest::SHA512.hexdigest(Settings.snippet.salt + Time.now.to_i.to_s)[0..19] unless @snippet.published?

    respond_to do |format|
      if @snippet.save
        redirect_to = @snippet.published? ? @snippet : "/snippets/#{@snippet.hash_id}"
        format.html { redirect_to redirect_to, notice: 'Snippet was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    if snippet = current_user.snippets.find_by_id(params[:id])
      snippet.destroy
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Snippet was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
