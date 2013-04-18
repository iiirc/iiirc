class MessagesController < ApplicationController
  def destroy
    @message = Message.find_by_id_and_snippet_id_and_user_id(params[:id], params[:snippet_id], current_user.id)
    @message.destroy

    respond_to do |format|
      format.html { redirect_to snippet_url(@message.snippet_id), status: 303 }
      format.json { head :no_content }
    end
  end
end
