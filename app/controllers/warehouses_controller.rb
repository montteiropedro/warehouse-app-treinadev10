class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    return redirect_to root_path, notice: 'Galpão cadastrado com sucesso.' if @warehouse.save
      
    flash.now[:notice] = 'Galpão não cadastrado.'
    render :new
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :description, :code, :address, :city, :cep, :area)
  end
end
