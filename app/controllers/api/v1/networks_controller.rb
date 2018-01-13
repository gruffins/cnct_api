class Api::V1::NetworksController < Api::V1::BaseController

  def index

  end

  def create
    network = Network.new(create_params)
 
    if network.save 
      render json: network, status: :created
    else
      render json: network.errors, status: :bad_request
    end
  end

  def update
    network = current_user.networks.find_by(id: params[:id])

    if network.present?
      if network.update_attributes(update_params)
        render json: network, status: :ok
      else
        render json: network.errors, status: :bad_request
      end
    else
      render json: { errors: { network: ['Network not found'] } }, status: :not_found 
    end
  end

  def destroy
    network = current_user.networks.find_by(id: params[:id])

    if network.present?
      render json: network.destroy, status: :ok
    else
      render json: { errors: { network: ['Network not found'] } }, status: :not_found
    end
  end

  private

  def create_params
    params.require(:network).permit(:ssid_hash, :authorization, :max_distance, :device_id)
  end

  def update_params
    params.require(:network).permit(:authorization, :max_distance)
  end

end