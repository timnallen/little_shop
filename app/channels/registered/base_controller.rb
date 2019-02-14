class Registered::BaseController < ApplicationController
  before_action :require_registered

  def require_registered
    render file: '/public/404' unless current_registered?
  end

  def current_registered?
    current_user && current_user.registered?
  end
end
