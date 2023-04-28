class ProductModelsController < ApplicationController
  before_action :set_product_model, only: [:show, :edit, :update]

  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.order(:brand_name)
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.'
    else
      @suppliers = Supplier.order(:brand_name)
      flash.now[:notice] = 'Falha ao cadastrar o modelo de produto.'
      render :new
    end
  end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(:name, :sku, :weight, :width, :height, :depth, :supplier_id)
  end
end
