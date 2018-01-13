class Api::V1::ConnectionsController < Api::V1::BaseController

  def index

  end

  def create
    connection = Connection.new(create_params.merge(user: current_user))

    if connection.save
      render json: connection, status: :created
    else
      render json: connection.errors, status: :bad_request
    end
  end

  def destroy
    connection = current_user.connections.find_by(id: params[:id])

    if connection.present?
      render json: connection.destroy, status: :ok
    else
      render json: { errors: { connection: ['Connection not found'] } }, status: :not_found
    end
  end

  def approve
    connection = current_user.connections.pending_received.find_by(id: params[:connection_id])

    if connection.try(:accept!)
      render json: connection, status: :ok
    else
      render json: { errors: { connection: ['Connection not found'] } }, status: :not_found
    end
  end

  def reject
    connection = current_user.connections.pending_received.find_by(id: params[:connection_id])

    if connection.try(:reject!)
      render json: connection, status: :ok
    else
      render json: { errors: { connection: ['Connection not found'] } }, status: :not_found
    end
  end

  private

  def search_params
    params.permit(:q, :page, :status)
  end

  def create_params
    params.require(:connection).permit(:other_id)
  end

end