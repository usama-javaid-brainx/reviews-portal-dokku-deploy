class HomeController < ActionController::Base
  before_action :authenticate_user!
  def index
    if current_user.second_view?
      redirect_to homepage_path
    else
      redirect_to reviews_path
    end
  end
end
