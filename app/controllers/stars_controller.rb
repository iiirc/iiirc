class StarsController < ApplicationController
  # @todo use transaction or 'INSERT OR UPDATE'
  def create
    message = Message.find(params[:message_id])
    star = Star.find_by_user_id_and_message_id(current_user.id, message.id)
    if star
      star.count += 1
      Rails.logger.debug 'exists'
    else
      star = Star.new(user_id: current_user.id, count: 1)
      Rails.logger.debug 'not exists'
    end

    respond_to do |format|
      if message.stars << star
        format.json { render json: star }
      else
        formatjson { render json: message.errors, status: unprocessable_entity }
      end
    end
  end
end
