class Api::V1::DevicesController < Api::V1::BaseController

  def create
    device = Device.find_or_create_device!(create_params, current_user)

    if device.valid?
      render json: device, status: :created
    else
      render json: { errors: device.errors }, status: :bad_request
    end
  end

  def destroy
    device = current_user.devices.find_by(id: params[:id])

    if device.present?
      render json: device.destroy, status: :ok
    else
      render json: { errors: { device: ['Device not found'] } }, status: :not_found
    end
  end

  protected

  def create_params
    params.require(:device).permit(:uuid)
  end

end