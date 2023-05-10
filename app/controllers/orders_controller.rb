class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_check_user, only: [:show, :edit, :update, :delivered, :canceled]

  def index
    @orders = current_user.orders
  end

  def show
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:corporate_name)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso.'
    else
      @warehouses = Warehouse.order(:name)
      @suppliers = Supplier.order(:corporate_name)
      flash.now[:notice] = 'Falha ao registrar o pedido.'
      render :new
    end
  end

  def edit
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:corporate_name)
  end

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      @warehouses = Warehouse.order(:name)
      @suppliers = Supplier.order(:corporate_name)
      flash.now[:notice] = 'Falha ao atualizar o pedido.'
      render :new
    end
  end

  def search
    @code = params[:query]
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  def delivered
    if @order.delivered!
      @order.order_items.each do |item|
        item.quantity.times do
          StockProduct.create!(order: @order, product_model: item.product_model, warehouse: @order.warehouse)
        end
      end
      redirect_to @order, notice: 'Pedido marcado como entregue.'
    else
      flash.now[:notice] = 'Falha ao marcar o pedido como entregue.'
      render :show
    end
  end

  def canceled
    if @order.canceled!
      redirect_to @order, notice: 'Pedido cancelado com sucesso.'
    else
      flash.now[:notice] = 'Falha ao cancelar o pedido.'
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def set_order_check_user
    @order = Order.find(params[:id])
    redirect_to root_path if @order.user != current_user
  end
end
