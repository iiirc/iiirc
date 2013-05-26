class StarsController < ApplicationController
  def create
    message = Message.find(params[:message_id])
    star    = Star.find_or_create_by(user_id: current_user.id, message_id: message.id)

    Star.transaction do
      star.increment(:count, 1)
      star.save!
    end

    render json: star, include: {
      user: { only: [:username, :gravatar_url], methods: [:gravatar_url] },
      message: { only: [], methods: [:star_count] }
    }
  rescue => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end
end
