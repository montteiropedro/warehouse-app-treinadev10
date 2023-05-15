class StockProductDestinationsController < ApplicationController
  def create
    warehouse = Warehouse.find(params[:warehouse_id])
    product_model = ProductModel.find(params[:product_model_id])

    stock_product = StockProduct.where.missing(:stock_product_destination).find_by(warehouse: warehouse, product_model: product_model)

    if stock_product.present?
      if stock_product.create_stock_product_destination!(
        recipient: params[:recipient], address: params[:address]
      )
        redirect_to warehouse, notice: 'Item retirado com sucesso.'
      else
        redirect_to warehouse, notice: 'Falha ao retirar o Item.'
      end
    end
  end

  # private

  # def stock_product_destinations_params
  #   params.permit(:recipient, :address)
  # end
end
