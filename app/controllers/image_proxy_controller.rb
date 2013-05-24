require 'open-uri'

class ImageProxyController < ApplicationController
  def show
    return render_bad_request 'parameter "of" is required' if params[:of].blank?
    image = URI(params[:of]).read
    status, message = image.status
    status = status.to_i
    if status != 200 or !image.content_type.start_with? 'image/'
      unless image.content_type.start_with? 'image/'
        status = 400
        message = 'Not image'
      end
      return render status: status, text: message, layout: false
    end
    render status: 200, text: image, content_type: image.content_type
  end
end
