class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new(order_item_params)
    @order_item.order = @order

    if @order_item.save
      redirect_to @order, notice: 'Item adicionado com sucesso.'
    else
      @product_models = @order.supplier.product_models
      flash.now[:notice] = 'Falha ao adicionar o item.'
      render :new
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end
end
