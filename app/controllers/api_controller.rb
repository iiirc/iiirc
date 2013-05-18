class ApiController < ApplicationController
  def render_not_found
    render text: "404 not found", status: 404, layout: false
  end
end
