class Api::V1::UsersController < Api::V1::BaseController

  def create
    user = User.new(create_params)

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user.present?
      render json: user, status: :ok
    else
      render json: { errors: { user: ['User not found'] } }, status: :not_found
    end
  end

  def update
    if current_user.id.to_s == params[:id].to_s
      if current_user.update_user update_params
        render json: current_user, status: :ok
      else
        render json: { errors: current_user.errors }, status: :bad_request
      end
    else
      render json: { errors: { user: ['Cannot edit other users' ] } }, status: :bad_request
    end
  end

  def me
    render json: current_user, status: :ok
  end

  private

  def create_params
    params.require(:user).permit(:username, :email, :password)
  end

  def update_params
    params.require(:user).permit(:username, :email, :password, :current_password)
  end

end