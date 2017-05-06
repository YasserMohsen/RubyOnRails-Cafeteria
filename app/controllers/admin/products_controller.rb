class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:show, :edit, :destroy]
  semantic_breadcrumb "Products", :admin_products_path

  def index
    @products = Product.all
  end

  def new
    semantic_breadcrumb "Create", new_admin_product_path
    @product = Product.new
  end

  def edit
    semantic_breadcrumb @product.name
  end

  def create
    # render plain: params[:product].inspect
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      semantic_breadcrumb "Create", new_admin_product_path
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      respond_to do |format|
          format.html{ redirect_to admin_products_path, notice: 'Product was successfully updated.' }
          fromat.json{ render json: {case: "ok"} }
        end
      else
        respond_to do |format|
          format.html{ render :edit }
          fromat.json{ render json: {case: "error"} }
        end
      end
    # respond_to do |format|
    #   format.html{
    #     @product = Product.find(params[:id])
    #     if @product.update(product_params)
    #       redirect_to admin_products_path, notice: 'Product was successfully updated.'
    #     else
    #       render :edit
    #     end
    #   }
    #   format.json{
    #     @product = Product.find(5)
    #     @product.availability(params[:availability])
    #     # @product.update(params[:availability])
    #     if @product.save
    #       render json: {case: "ok"}
    #     else
    #       render json: {case: "error"}
    #     end
    #   }
    # end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, alert: 'Product was successfully destroyed.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :availability, :picture, :category_id)
    end
end
