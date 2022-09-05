class UsersController < ApplicationController
  def index
    reviews = review_filter(current_user.reviews.kept)
    @pagy, @reviews = pagy(reviews, items: 12)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    debugger

    if @user.update_with_password(params)
      sign_in @user, :bypass => true

      redirect_to root_path, :notice => "Your Password has been updated!"
    else

      flash[:alert] = @user.errors.full_messages.join("<br />")
      render :edit

    end

    if @user.update(user_params)
      debugger
      # redirect_to user_profile
    else
      debugger
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_params
    params[:last_name] = current_user.last_name
    params[:email] = current_user.email
    params[:encrypted_password] = current_user.encrypted_password
    debugger
    params.permit(:first_name, :avatar)
  end

  def review_filter(reviews)
    params[:to_try] = 'all' unless params[:to_try].present?
    params[:category] = 'all' unless params[:category].present?
    reviews = params[:category] == 'all' ? reviews : reviews.where(category_id: Category.find_by(name: params[:category])) if params[:category].present?

    reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try] == 'true') if params[:to_try].present?
    if params[:to_try] != 'favourite'
      reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try] == 'true') if params[:to_try].present?
    else
      reviews = reviews.where(favourite: true) if params[:to_try].present?
    end
    reviews = reviews.order("average_score #{params[:score].to_s} NULLS LAST") if params[:score].present?
    reviews
  end
end
