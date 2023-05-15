class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show
    @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    @product_models = @stocks.keys
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Galpão não cadastrado.'
      render :new
    end
  end

  def edit
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso.'
    else
      flash.now[:notice] = 'Falha ao atualizar o galpão.'
      render :edit
    end
  end

  def destroy
    if @warehouse.destroy
      redirect_to root_path, notice: 'Galpão removido com sucesso.'
    else
      flash.now[:notice] = 'Falha ao remover o galpão.'
      render :show
    end
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :description, :code, :address, :city, :cep, :area)
  end
end
