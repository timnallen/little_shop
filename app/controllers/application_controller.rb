class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :render_nav

  private

  def render_nav
    render partial: "nav/visitor"
  end
end
