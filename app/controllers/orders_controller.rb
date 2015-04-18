class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @items = Item.all
    @price_array = Item.pluck(:rate)
    @sum = Item.sum(:rate)
    @count = Item.count(:qty)
    @date = Order.pluck(:order_date)
    @order_date = @date.join(',')
    @temp = Item.where(:received => 1).count()
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.all
    @items = Item.all
    @count = Item.count(:qty)
    @temp = Item.where(:received => 1).count()
    @kit = IMGKit.new(render_to_string(:layout => "orders/new", :layout => false),
                                      width: 300, height: 340)
    img = @kit.to_jpg
    send_data(img, :type => "image/jpeg", :disposition => 'inline')
      return
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @orders = Order.all
    @items = Item.all
    @count = Item.count(:qty)
    @temp = Item.where(:received => 1).count()
    render  :pdf => "Bill" , 
            :template => 'orders/create.pdf.erb', # Excluding ".pdf" extension.
            page_height:  100,
            page_width:   80,
            outline: {  outline:   true}
     
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_no, :order_date, :customer_name)
    end
end
