class StarsController < ApplicationController
  # @todo use transaction or 'INSERT OR UPDATE'
  def create
    message = Message.find(params[:message_id])
    star = Star.find_or_create_by_user_id_and_message_id(current_user.id, message.id)

    respond_to do |format|
      if message.stars << star
        format.json { render json: star, include: { user: { only: [:username, :gravatar_url], methods: [:gravatar_url] } } }
      else
        format.json { render json: message.errors, status: unprocessable_entity }
      end
    end
  end
end
