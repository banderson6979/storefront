module Api
  class BaseController < ApplicationController
    respond_to :json
    before_action :default_json

    protected

    def auth_only!
      render json: {}, status: 401 unless current_user
    end

    def default_json
      request.format = :json if params[:format].nil?
    end
  end
end
