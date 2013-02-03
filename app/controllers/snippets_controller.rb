class SnippetsController < ApplicationController
  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.published

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snippets }
    end
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @snippet = Snippet.find_by_hash_id(params[:id])
    if @snippet.blank?
      @snippet = Snippet.find_by_id(params[:id])
      return render status: :not_found, text: "404 not found" unless @snippet.published?
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
  # POST /snippets.json
  def create
    return render status: :forbidden, text: "Hey! Forbidden fruit :S" if current_user.blank?
    @content = params[:content].strip
    @snippet = current_user.snippets.build(params[:snippet])
    @snippet.published = params[:commit] == "public"  # あとでもうちょっとちゃんとします...
    @snippet.content = @content
    @snippet.hash_id = Digest::SHA512.hexdigest(Time.now.to_i.to_s)[0..19] unless @snippet.published?

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
        format.json { render json: @snippet, status: :created, location: @snippet }
      else
        format.html { render action: "new" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /snippets/1
  # PUT /snippets/1.json
  def update
    @snippet = Snippet.find(params[:id])

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet = Snippet.find(params[:id])
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to snippets_url }
      format.json { head :no_content }
    end
  end
end
