class Merchant::BaseController < ApplicationController
  before_action :require_merchant

  def require_merchant
    render file: '/public/404' unless current_merchant?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end
end
