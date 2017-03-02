class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :decrease]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :decrease]
  skip_before_filter :verify_authenticity_token
  
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end
  
  def decrease
    @cart = Cart.find(session[:cart_id])
    @line_item = LineItem.find_by_id(params[:id])
    @product = Product.find(@line_item.product)
    @product.popularity = @product.popularity - 1;
    @product.update_attributes(:popularity => @product.popularity)
    respond_to do |format|
      if @line_item.quantity > 1
        @line_item.update_attribute(:quantity, @line_item.quantity -= 1)
        format.html { redirect_to store_index_url }
        format.js   { @current_item = @line_item  }
        format.json {  }
      else
        @line_item.destroy
        format.html { render action: "edit" }
        format.js   { render 'decrease.js.erb' if !@cart.line_items.present?}
        format.json {  }
      end
    end
  end
  # GET /line_items/1
  # GET /line_items/1.json
  
  def show_orders_for_seller
    seller = Seller.find(params[:id]) 
    authorize seller, :show_orders_for_seller?
    products = seller.products
    @line_items = LineItem.where(product_id: products)
    products.each do |product|
      logger.info(product)
    end
  end
  
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        session[:counter]=0
        product.popularity = product.popularity + 1;
        product.update_attributes(:popularity => product.popularity)
        format.html { redirect_to store_index_url }
        #format.js   { @current_item = @line_item }
        format.json { }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @product = @line_item.product
    @product.popularity = @product.popularity - 1;
    @product.update_attributes(:popularity => product.popularity)
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
